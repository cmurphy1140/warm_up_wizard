import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:drift/drift.dart';
import '../database/database.dart';
import '../database/tables.dart';

class MoveService {
  final AppDatabase _database;

  MoveService(this._database);

  Future<void> loadSeedMoves() async {
    // Check if moves are already loaded
    final existingMoves = await _database.select(_database.moves).get();
    if (existingMoves.isNotEmpty) {
      return; // Moves already loaded
    }

    // Load seed moves from JSON
    final jsonString = await rootBundle.loadString('assets/moves/seed_moves.json');
    final List<dynamic> movesList = json.decode(jsonString);

    for (final moveData in movesList) {
      await _insertMoveFromJson(moveData);
    }
  }

  Future<void> _insertMoveFromJson(Map<String, dynamic> json) async {
    // Parse equipment list
    final List<Equipment> equipmentList = [];
    if (json['needs_equipment'] != null) {
      for (final equipmentName in json['needs_equipment']) {
        switch (equipmentName) {
          case 'cones':
            equipmentList.add(Equipment.cones);
            break;
          case 'balls':
            equipmentList.add(Equipment.balls);
            break;
          case 'ropes':
            equipmentList.add(Equipment.ropes);
            break;
          case 'hullahoop':
            equipmentList.add(Equipment.hullahoop);
            break;
          default:
            equipmentList.add(Equipment.none);
        }
      }
    }

    // Parse space type
    SpaceType spaceType;
    switch (json['needs_space']) {
      case 'fullGym':
        spaceType = SpaceType.fullGym;
        break;
      case 'halfGym':
        spaceType = SpaceType.halfGym;
        break;
      case 'hallway':
        spaceType = SpaceType.hallway;
        break;
      case 'classroom':
        spaceType = SpaceType.classroom;
        break;
      case 'courtyard':
        spaceType = SpaceType.courtyard;
        break;
      default:
        spaceType = SpaceType.classroom;
    }

    // Parse impact level
    ImpactLevel impact;
    switch (json['impact']) {
      case 'low':
        impact = ImpactLevel.low;
        break;
      case 'moderate':
        impact = ImpactLevel.moderate;
        break;
      case 'high':
        impact = ImpactLevel.high;
        break;
      default:
        impact = ImpactLevel.low;
    }

    // Parse noise level
    NoiseLevel noise;
    switch (json['noise']) {
      case 'quiet':
        noise = NoiseLevel.quiet;
        break;
      case 'moderate':
        noise = NoiseLevel.moderate;
        break;
      case 'loud':
        noise = NoiseLevel.loud;
        break;
      default:
        noise = NoiseLevel.quiet;
    }

    // Create move entry
    final move = MovesCompanion.insert(
      name: json['name'],
      tags: jsonEncode(json['tags'] ?? []),
      gradeMin: json['grade_min'] ?? 0,
      gradeMax: json['grade_max'] ?? 8,
      needsSpace: spaceType,
      needsEquipment: jsonEncode(equipmentList.map((e) => e.name).toList()),
      impact: impact,
      noise: noise,
      allowFloor: Value(json['allow_floor'] ?? true),
      defaultDurationS: Value(json['default_duration_s'] ?? 30),
      keyframes: Value(json['keyframes'] != null ? jsonEncode(json['keyframes']) : null),
      lottieAssetPath: Value(json['lottie_asset_path']),
    );

    await _database.into(_database.moves).insert(move);
  }

  Future<List<Move>> getAllMoves() async {
    return await _database.select(_database.moves).get();
  }

  Future<List<Move>> getMovesForConstraints({
    required GradeBand gradeBand,
    required SpaceType space,
    required List<Equipment> equipment,
    bool allowFloor = true,
    ImpactLevel maxImpact = ImpactLevel.high,
    NoiseLevel maxNoise = NoiseLevel.loud,
  }) async {
    // Get all moves and filter in Dart for simplicity
    final allMoves = await getAllMoves();
    
    // Determine grade range
    int minGrade, maxGrade;
    switch (gradeBand) {
      case GradeBand.k2:
        minGrade = 0;
        maxGrade = 2;
        break;
      case GradeBand.grades3to5:
        minGrade = 3;
        maxGrade = 5;
        break;
      case GradeBand.grades6to8:
        minGrade = 6;
        maxGrade = 8;
        break;
    }

    return allMoves.where((move) {
      // Grade filter - check if move is appropriate for grade range
      if (move.gradeMin > maxGrade || move.gradeMax < minGrade) {
        return false;
      }
      
      // Space filter - exact match for now (could be more sophisticated)
      if (move.needsSpace != space) {
        return false;
      }
      
      // Impact filter
      if (move.impact.index > maxImpact.index) {
        return false;
      }
      
      // Noise filter
      if (move.noise.index > maxNoise.index) {
        return false;
      }
      
      // Floor filter
      if (!allowFloor && move.allowFloor) {
        return false;
      }
      
      // Equipment filter
      final List<String> requiredEquipment = List<String>.from(jsonDecode(move.needsEquipment));
      final availableEquipmentNames = equipment.map((e) => e.name).toSet();
      
      return requiredEquipment.every((req) => 
        req == Equipment.none.name || availableEquipmentNames.contains(req));
    }).toList();
  }

  Future<Move?> getMoveById(int id) async {
    final query = _database.select(_database.moves)
      ..where((move) => move.id.equals(id));
    
    final moves = await query.get();
    return moves.isNotEmpty ? moves.first : null;
  }
}