import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/routine_models.dart';
import '../database/database.dart';
import 'move_service.dart';

enum PlayerState {
  stopped,
  playing,
  paused,
  completed,
}

class RoutinePlayerState {
  final List<RoutineBlock> blocks;
  final int currentBlockIndex;
  final int remainingSeconds;
  final int totalElapsedSeconds;
  final PlayerState playerState;
  final Move? currentMove;
  final Move? nextMove;
  final bool isTransitioning;
  final String? currentCaption;

  const RoutinePlayerState({
    this.blocks = const [],
    this.currentBlockIndex = 0,
    this.remainingSeconds = 0,
    this.totalElapsedSeconds = 0,
    this.playerState = PlayerState.stopped,
    this.currentMove,
    this.nextMove,
    this.isTransitioning = false,
    this.currentCaption,
  });

  RoutinePlayerState copyWith({
    List<RoutineBlock>? blocks,
    int? currentBlockIndex,
    int? remainingSeconds,
    int? totalElapsedSeconds,
    PlayerState? playerState,
    Move? currentMove,
    Move? nextMove,
    bool? isTransitioning,
    String? currentCaption,
  }) {
    return RoutinePlayerState(
      blocks: blocks ?? this.blocks,
      currentBlockIndex: currentBlockIndex ?? this.currentBlockIndex,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      totalElapsedSeconds: totalElapsedSeconds ?? this.totalElapsedSeconds,
      playerState: playerState ?? this.playerState,
      currentMove: currentMove ?? this.currentMove,
      nextMove: nextMove ?? this.nextMove,
      isTransitioning: isTransitioning ?? this.isTransitioning,
      currentCaption: currentCaption ?? this.currentCaption,
    );
  }

  int get totalRoutineSeconds {
    return blocks.fold(0, (sum, block) => sum + block.seconds);
  }

  int get currentBlockSeconds {
    return currentBlockIndex < blocks.length ? blocks[currentBlockIndex].seconds : 0;
  }

  int get progressSeconds {
    return totalElapsedSeconds + (currentBlockSeconds - remainingSeconds);
  }

  double get progress {
    final total = totalRoutineSeconds;
    return total > 0 ? progressSeconds / total : 0.0;
  }
}

class RoutinePlayerService extends StateNotifier<RoutinePlayerState> {
  final MoveService _moveService;
  Timer? _timer;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final FlutterTts _tts = FlutterTts();
  bool _soundEnabled = true;
  bool _ttsEnabled = true;

  RoutinePlayerService(this._moveService) : super(const RoutinePlayerState()) {
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    await _tts.setLanguage("en-US");
    await _tts.setSpeechRate(0.8);
    await _tts.setVolume(0.8);
    await _tts.setPitch(1.0);
  }

  Future<void> loadRoutine(List<RoutineBlock> blocks) async {
    _stopTimer();
    
    // Load current and next moves
    final currentMove = blocks.isNotEmpty
        ? await _moveService.getMoveById(int.parse(blocks[0].moveId))
        : null;
    
    final nextMove = blocks.length > 1
        ? await _moveService.getMoveById(int.parse(blocks[1].moveId))
        : null;

    state = RoutinePlayerState(
      blocks: blocks,
      currentBlockIndex: 0,
      remainingSeconds: blocks.isNotEmpty ? blocks[0].seconds : 0,
      totalElapsedSeconds: 0,
      playerState: PlayerState.stopped,
      currentMove: currentMove,
      nextMove: nextMove,
      currentCaption: currentMove?.name ?? '',
    );
  }

  Future<void> play() async {
    if (state.blocks.isEmpty) return;

    if (state.playerState == PlayerState.paused) {
      _startTimer();
      state = state.copyWith(playerState: PlayerState.playing);
    } else if (state.playerState == PlayerState.stopped) {
      await _startNewRoutine();
    }
  }

  void pause() {
    if (state.playerState == PlayerState.playing) {
      _stopTimer();
      state = state.copyWith(playerState: PlayerState.paused);
    }
  }

  void stop() {
    _stopTimer();
    state = state.copyWith(
      playerState: PlayerState.stopped,
      currentBlockIndex: 0,
      remainingSeconds: state.blocks.isNotEmpty ? state.blocks[0].seconds : 0,
      totalElapsedSeconds: 0,
      isTransitioning: false,
    );
  }

  Future<void> skipToNext() async {
    if (state.currentBlockIndex < state.blocks.length - 1) {
      await _moveToNextBlock();
    }
  }

  Future<void> skipToPrevious() async {
    if (state.currentBlockIndex > 0) {
      final prevIndex = state.currentBlockIndex - 1;
      final prevBlock = state.blocks[prevIndex];
      final prevMove = await _moveService.getMoveById(int.parse(prevBlock.moveId));
      
      // Calculate elapsed time up to previous block
      int elapsedTime = 0;
      for (int i = 0; i < prevIndex; i++) {
        elapsedTime += state.blocks[i].seconds;
      }

      state = state.copyWith(
        currentBlockIndex: prevIndex,
        remainingSeconds: prevBlock.seconds,
        totalElapsedSeconds: elapsedTime,
        currentMove: prevMove,
        currentCaption: prevMove?.name ?? '',
        isTransitioning: false,
      );

      await _updateNextMove();
    }
  }

  Future<void> extendCurrentBlock(int additionalSeconds) async {
    if (state.playerState == PlayerState.playing || state.playerState == PlayerState.paused) {
      final newRemainingSeconds = state.remainingSeconds + additionalSeconds;
      state = state.copyWith(remainingSeconds: newRemainingSeconds);
      
      // Update the block duration in the list
      final updatedBlocks = [...state.blocks];
      updatedBlocks[state.currentBlockIndex] = RoutineBlock(
        moveId: updatedBlocks[state.currentBlockIndex].moveId,
        seconds: updatedBlocks[state.currentBlockIndex].seconds + additionalSeconds,
        intensity: updatedBlocks[state.currentBlockIndex].intensity,
      );
      
      state = state.copyWith(blocks: updatedBlocks);
    }
  }

  void restart() {
    stop();
  }

  void setSoundEnabled(bool enabled) {
    _soundEnabled = enabled;
  }

  void setTtsEnabled(bool enabled) {
    _ttsEnabled = enabled;
  }

  Future<void> _startNewRoutine() async {
    if (state.blocks.isEmpty) return;
    
    _startTimer();
    state = state.copyWith(playerState: PlayerState.playing);
    
    if (_ttsEnabled) {
      await _speak("Starting routine. ${state.currentMove?.name ?? 'First exercise'}");
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), _onTimerTick);
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _onTimerTick(Timer timer) async {
    if (state.remainingSeconds > 1) {
      // Continue current block
      final newRemainingSeconds = state.remainingSeconds - 1;
      state = state.copyWith(remainingSeconds: newRemainingSeconds);
      
      // Handle warnings and announcements
      await _handleTimewarnings(newRemainingSeconds);
      
    } else {
      // Block finished, move to next or complete routine
      await _moveToNextBlock();
    }
  }

  Future<void> _handleTimewarnings(int remainingSeconds) async {
    // 5-second warning with next move announcement
    if (remainingSeconds == 5 && state.nextMove != null) {
      state = state.copyWith(
        currentCaption: "Next: ${state.nextMove!.name}",
        isTransitioning: true,
      );
      
      if (_ttsEnabled) {
        await _speak("Next: ${state.nextMove!.name}");
      }
    }
    
    // Countdown for last 3 seconds
    if (remainingSeconds <= 3 && remainingSeconds > 0) {
      if (_soundEnabled) {
        await _playBeep();
      }
      if (_ttsEnabled && remainingSeconds <= 3) {
        await _speak(remainingSeconds.toString());
      }
    }
  }

  Future<void> _moveToNextBlock() async {
    final nextIndex = state.currentBlockIndex + 1;
    
    if (nextIndex >= state.blocks.length) {
      // Routine completed
      _stopTimer();
      state = state.copyWith(
        playerState: PlayerState.completed,
        currentCaption: "Routine Complete! Great job!",
        isTransitioning: false,
      );
      
      if (_ttsEnabled) {
        await _speak("Routine complete! Great job!");
      }
      if (_soundEnabled) {
        await _playCompletionSound();
      }
      return;
    }
    
    // Move to next block
    final nextBlock = state.blocks[nextIndex];
    final nextMove = await _moveService.getMoveById(int.parse(nextBlock.moveId));
    
    // Calculate total elapsed time
    int totalElapsed = 0;
    for (int i = 0; i <= state.currentBlockIndex; i++) {
      totalElapsed += state.blocks[i].seconds;
    }
    
    state = state.copyWith(
      currentBlockIndex: nextIndex,
      remainingSeconds: nextBlock.seconds,
      totalElapsedSeconds: totalElapsed,
      currentMove: nextMove,
      currentCaption: nextMove?.name ?? '',
      isTransitioning: false,
    );
    
    await _updateNextMove();
    
    // Transition beep and announcement
    if (_soundEnabled) {
      await _playTransitionBeep();
    }
    
    if (_ttsEnabled) {
      await _speak(nextMove?.name ?? "Next exercise");
    }
  }

  Future<void> _updateNextMove() async {
    final nextIndex = state.currentBlockIndex + 1;
    if (nextIndex < state.blocks.length) {
      final nextBlock = state.blocks[nextIndex];
      final nextMove = await _moveService.getMoveById(int.parse(nextBlock.moveId));
      state = state.copyWith(nextMove: nextMove);
    } else {
      state = state.copyWith(nextMove: null);
    }
  }

  Future<void> _speak(String text) async {
    try {
      await _tts.speak(text);
    } catch (e) {
      debugPrint('TTS Error: $e');
    }
  }

  Future<void> _playBeep() async {
    try {
      // Play system sound or generate a simple beep
      SystemSound.play(SystemSoundType.click);
    } catch (e) {
      debugPrint('Sound Error: $e');
    }
  }

  Future<void> _playTransitionBeep() async {
    try {
      // Different sound for transitions
      SystemSound.play(SystemSoundType.alert);
    } catch (e) {
      debugPrint('Sound Error: $e');
    }
  }

  Future<void> _playCompletionSound() async {
    try {
      // Completion sound
      SystemSound.play(SystemSoundType.alert);
      // Could play a success sound file here if available
    } catch (e) {
      debugPrint('Sound Error: $e');
    }
  }

  @override
  void dispose() {
    _stopTimer();
    _audioPlayer.dispose();
    super.dispose();
  }
}

// Provider for the routine player
final routinePlayerProvider = StateNotifierProvider<RoutinePlayerService, RoutinePlayerState>((ref) {
  // You'd need to provide MoveService here - this is just a placeholder
  throw UnimplementedError('MoveService needs to be provided');
});

// Provider factory that takes MoveService
StateNotifierProvider<RoutinePlayerService, RoutinePlayerState> routinePlayerProviderWithService(MoveService moveService) {
  return StateNotifierProvider<RoutinePlayerService, RoutinePlayerState>((ref) {
    return RoutinePlayerService(moveService);
  });
}