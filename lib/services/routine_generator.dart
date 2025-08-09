import 'dart:convert';
import 'dart:math';
import '../database/database.dart';
import '../database/tables.dart';
import '../models/routine_models.dart';
import 'move_service.dart';

class RoutineGenerationRequest {
  final GradeBand gradeBand;
  final SpaceType space;
  final List<Equipment> equipment;
  final RoutineType type;
  final int targetLengthSeconds;
  final RoutineConstraints constraints;

  const RoutineGenerationRequest({
    required this.gradeBand,
    required this.space,
    required this.equipment,
    required this.type,
    required this.targetLengthSeconds,
    this.constraints = const RoutineConstraints(),
  });
}

class RoutineGenerator {
  final MoveService _moveService;
  final Random _random = Random();

  RoutineGenerator(this._moveService);

  Future<List<RoutineBlock>> generateRoutine(RoutineGenerationRequest request) async {
    // Get available moves based on constraints
    final availableMoves = await _getAvailableMoves(request);
    
    if (availableMoves.isEmpty) {
      throw Exception('No moves available for the given constraints');
    }

    // Generate routine blocks
    final blocks = await _generateBlocks(
      moves: availableMoves,
      targetSeconds: request.targetLengthSeconds,
      type: request.type,
      constraints: request.constraints,
    );

    return blocks;
  }

  Future<List<Move>> _getAvailableMoves(RoutineGenerationRequest request) async {
    List<Move> moves = await _moveService.getMovesForConstraints(
      gradeBand: request.gradeBand,
      space: request.space,
      equipment: request.equipment,
      allowFloor: !request.constraints.noFloor,
      maxImpact: ImpactLevel.values[request.constraints.maxImpact],
      maxNoise: NoiseLevel.values[request.constraints.maxNoise],
    );

    // Filter by classroom tight constraint
    if (request.constraints.classroomTight) {
      moves = moves.where((move) {
        final tags = List<String>.from(jsonDecode(move.tags));
        return move.needsSpace == SpaceType.classroom && 
               !tags.contains('floor') &&
               move.allowFloor == false;
      }).toList();
    }

    // Exclude moves if specified
    if (request.constraints.excludeMoves.isNotEmpty) {
      moves = moves.where((move) => 
        !request.constraints.excludeMoves.contains(move.id.toString())).toList();
    }

    return moves;
  }

  Future<List<RoutineBlock>> _generateBlocks({
    required List<Move> moves,
    required int targetSeconds,
    required RoutineType type,
    required RoutineConstraints constraints,
  }) async {
    final List<RoutineBlock> blocks = [];
    int remainingSeconds = targetSeconds;
    const int tolerance = 10; // ±10 seconds tolerance
    
    // Track recently used moves for variety
    final List<String> recentMoves = [];
    const int varietyWindow = 3; // Don't repeat moves within last 3 selections

    // Intensity progression phases
    final intensityPhases = _getIntensityProgression(type, targetSeconds);
    int currentPhaseIndex = 0;
    int phaseStartTime = 0;

    while (remainingSeconds > tolerance && currentPhaseIndex < intensityPhases.length) {
      final currentPhase = intensityPhases[currentPhaseIndex];
      final phaseEndTime = phaseStartTime + currentPhase['duration'] as int;
      final targetIntensity = currentPhase['intensity'] as String;
      
      // Select a move for this block
      final selectedMove = _selectMove(
        moves: moves,
        recentMoves: recentMoves,
        targetIntensity: targetIntensity,
        constraints: constraints,
        lastBlock: blocks.isNotEmpty ? blocks.last : null,
      );

      if (selectedMove == null) {
        // Backtrack if no suitable move found
        if (blocks.isNotEmpty) {
          final lastBlock = blocks.removeLast();
          remainingSeconds += lastBlock.seconds;
          recentMoves.remove(lastBlock.moveId);
          continue;
        } else {
          throw Exception('Unable to generate routine with given constraints');
        }
      }

      // Determine block duration
      int blockDuration = _calculateBlockDuration(
        move: selectedMove,
        remainingSeconds: remainingSeconds,
        targetIntensity: targetIntensity,
        isLastBlock: remainingSeconds <= selectedMove.defaultDurationS + tolerance,
      );

      // Create the block
      final block = RoutineBlock(
        moveId: selectedMove.id.toString(),
        seconds: blockDuration,
        intensity: targetIntensity,
      );

      blocks.add(block);
      remainingSeconds -= blockDuration;
      
      // Update tracking
      recentMoves.add(selectedMove.id.toString());
      if (recentMoves.length > varietyWindow) {
        recentMoves.removeAt(0);
      }

      // Check if we should move to next phase
      final totalTime = targetSeconds - remainingSeconds;
      if (totalTime >= phaseEndTime && currentPhaseIndex < intensityPhases.length - 1) {
        currentPhaseIndex++;
        phaseStartTime = phaseEndTime;
      }
    }

    return blocks;
  }

  Move? _selectMove({
    required List<Move> moves,
    required List<String> recentMoves,
    required String targetIntensity,
    required RoutineConstraints constraints,
    RoutineBlock? lastBlock,
  }) {
    // Filter moves based on safety rules
    var candidateMoves = moves.where((move) {
      // Avoid recently used moves
      if (recentMoves.contains(move.id.toString())) {
        return false;
      }

      // Safety: no two high-impact moves in a row
      if (lastBlock != null) {
        final lastMoveId = int.tryParse(lastBlock.moveId);
        if (lastMoveId != null) {
          final lastMove = moves.firstWhere((m) => m.id == lastMoveId, orElse: () => moves.first);
          if (lastMove.impact == ImpactLevel.high && move.impact == ImpactLevel.high) {
            return false;
          }
        }
      }

      return true;
    }).toList();

    if (candidateMoves.isEmpty) {
      candidateMoves = moves; // Fallback to all moves if filtering is too restrictive
    }

    // Weight moves based on various factors
    final weightedMoves = candidateMoves.map((move) {
      double weight = 1.0;

      // Prefer moves matching target intensity
      final moveTags = List<String>.from(jsonDecode(move.tags));
      if (_matchesIntensity(moveTags, targetIntensity)) {
        weight *= 2.0;
      }

      // Prefer moves in preferred list
      if (constraints.preferMoves.contains(move.id.toString())) {
        weight *= 1.5;
      }

      // Slight randomization for variety
      weight *= (0.8 + _random.nextDouble() * 0.4);

      return MapEntry(move, weight);
    }).toList();

    // Sort by weight and select from top candidates
    weightedMoves.sort((a, b) => b.value.compareTo(a.value));
    
    // Select from top 20% of weighted moves for some randomness
    final topCandidatesCount = (weightedMoves.length * 0.2).ceil().clamp(1, 5);
    final topCandidates = weightedMoves.take(topCandidatesCount).toList();
    
    return topCandidates[_random.nextInt(topCandidates.length)].key;
  }

  bool _matchesIntensity(List<String> tags, String targetIntensity) {
    switch (targetIntensity) {
      case 'easy':
        return tags.any((tag) => ['mobility', 'balance', 'warmup'].contains(tag));
      case 'moderate':
        return tags.any((tag) => ['cardio', 'coordination'].contains(tag));
      case 'spicy':
        return tags.any((tag) => ['strength', 'agility', 'high_intensity'].contains(tag));
      default:
        return false;
    }
  }

  int _calculateBlockDuration({
    required Move move,
    required int remainingSeconds,
    required String targetIntensity,
    required bool isLastBlock,
  }) {
    int baseDuration = move.defaultDurationS;
    
    // Adjust duration based on intensity
    switch (targetIntensity) {
      case 'easy':
        baseDuration = (baseDuration * 1.2).round(); // Longer for easier moves
        break;
      case 'spicy':
        baseDuration = (baseDuration * 0.8).round(); // Shorter for intense moves
        break;
    }

    // Clamp duration to reasonable bounds
    baseDuration = baseDuration.clamp(15, 60);

    // Adjust if it's the last block
    if (isLastBlock) {
      return remainingSeconds.clamp(15, baseDuration + 15);
    }

    return baseDuration;
  }

  List<Map<String, dynamic>> _getIntensityProgression(RoutineType type, int totalSeconds) {
    switch (type) {
      case RoutineType.mobility:
        return [
          {'intensity': 'easy', 'duration': totalSeconds},
        ];
      
      case RoutineType.cardio:
        // Warm up -> Peak -> Cool down
        return [
          {'intensity': 'easy', 'duration': (totalSeconds * 0.2).round()},
          {'intensity': 'spicy', 'duration': (totalSeconds * 0.6).round()},
          {'intensity': 'moderate', 'duration': (totalSeconds * 0.2).round()},
        ];
      
      case RoutineType.mixed:
        // Gradual build-up
        return [
          {'intensity': 'easy', 'duration': (totalSeconds * 0.3).round()},
          {'intensity': 'moderate', 'duration': (totalSeconds * 0.4).round()},
          {'intensity': 'spicy', 'duration': (totalSeconds * 0.3).round()},
        ];
    }
  }
}