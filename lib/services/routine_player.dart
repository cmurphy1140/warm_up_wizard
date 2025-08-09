import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
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
  // Background ambient bytes cache
  Uint8List? _ambientWav;
  String? _ambientFilePath;

  RoutinePlayerService(this._moveService) : super(const RoutinePlayerState()) {
    _initializeAudio();
  }

  Future<void> _initializeAudio() async {
    // No TTS or sound initialization needed
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
      await _startAmbient();
      state = state.copyWith(playerState: PlayerState.playing);
    } else if (state.playerState == PlayerState.stopped) {
      await _startNewRoutine();
    }
  }

  void pause() {
    if (state.playerState == PlayerState.playing) {
      _stopTimer();
      _pauseAmbient();
      state = state.copyWith(playerState: PlayerState.paused);
    }
  }

  void stop() {
    _stopTimer();
    _stopAmbient();
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

  Future<void> _startNewRoutine() async {
    if (state.blocks.isEmpty) return;
    _startTimer();
    await _startAmbient();
    state = state.copyWith(playerState: PlayerState.playing);
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
      final newRemainingSeconds = state.remainingSeconds - 1;
      state = state.copyWith(remainingSeconds: newRemainingSeconds);
      await _handleTimewarnings(newRemainingSeconds);
    } else {
      await _moveToNextBlock();
    }
  }

  Future<void> _handleTimewarnings(int remainingSeconds) async {
    // Show visual cue only; no beeps/tts
    if (remainingSeconds == 5 && state.nextMove != null) {
      state = state.copyWith(
        currentCaption: "Next: ${state.nextMove!.name}",
        isTransitioning: true,
      );
    }
  }

  Future<void> _moveToNextBlock() async {
    final nextIndex = state.currentBlockIndex + 1;
    
    if (nextIndex >= state.blocks.length) {
      // Routine completed
      _stopTimer();
      _stopAmbient();
      state = state.copyWith(
        playerState: PlayerState.completed,
        currentCaption: "Routine Complete! Great job!",
        isTransitioning: false,
      );
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

  // === Ambient audio ===
  Future<void> _startAmbient() async {
    try {
      if (_ambientFilePath == null) {
        // Generate bytes if needed
        _ambientWav ??= _generateZenPadWav(durationSeconds: 8);
        // Write to a temp file for iOS/Android compatibility
        final tmpDir = await getTemporaryDirectory();
        final file = File('${tmpDir.path}/ambient_zen.wav');
        await file.writeAsBytes(_ambientWav!, flush: true);
        _ambientFilePath = file.path;
        await _audioPlayer.setAudioSource(AudioSource.uri(Uri.file(_ambientFilePath!)));
        await _audioPlayer.setLoopMode(LoopMode.one);
        await _audioPlayer.setVolume(0.15);
      }
      if (_audioPlayer.playing) return;
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Ambient audio error: $e');
    }
  }

  void _pauseAmbient() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    }
  }

  void _stopAmbient() {
    _audioPlayer.stop();
  }

  // Generate a soft, gentle pad as 16-bit PCM WAV bytes
  Uint8List _generateZenPadWav({int sampleRate = 44100, int durationSeconds = 8}) {
    final totalSamples = sampleRate * durationSeconds;
    final channels = 1;
    final bytesPerSample = 2; // 16-bit

    // Build PCM samples
    final pcmBuilder = BytesBuilder();
    // Frequencies for a C major-like airy chord
    final freqs = [196.0, 261.63, 329.63, 392.0]; // G3, C4, E4, G4
    for (int n = 0; n < totalSamples; n++) {
      final t = n / sampleRate;
      // Slow attack/decay envelope
      final attack = 2.0; // seconds
      final decay = 2.0; // seconds
      double env = 1.0;
      if (t < attack) {
        env = t / attack;
      } else if (t > durationSeconds - decay) {
        env = (durationSeconds - t) / decay;
      }
      env = env.clamp(0.0, 1.0);

      // Gentle LFO for warmth
      final lfo = 0.5 + 0.5 * math.sin(2 * math.pi * 0.1 * t);

      double sample = 0.0;
      for (final f in freqs) {
        // slight detune per voice
        final detune = (0.001 * (f % 3)) * math.sin(2 * math.pi * 0.05 * t);
        sample += math.sin(2 * math.pi * (f + detune) * t);
      }
      sample /= freqs.length; // average
      sample *= (0.15 * env * lfo); // low volume

      // 16-bit PCM conversion
      final intSample = (sample * 32767).clamp(-32768, 32767).toInt();
      pcmBuilder.addByte(intSample & 0xFF);
      pcmBuilder.addByte((intSample >> 8) & 0xFF);
    }

    final pcmBytes = pcmBuilder.toBytes();

    // WAV header
    final byteCount = pcmBytes.length;
    final header = BytesBuilder();
    void writeString(String s) => header.add(s.codeUnits);
    void writeUint32(int v) {
      header.addByte(v & 0xFF);
      header.addByte((v >> 8) & 0xFF);
      header.addByte((v >> 16) & 0xFF);
      header.addByte((v >> 24) & 0xFF);
    }
    void writeUint16(int v) {
      header.addByte(v & 0xFF);
      header.addByte((v >> 8) & 0xFF);
    }

    writeString('RIFF');
    writeUint32(36 + byteCount);
    writeString('WAVE');
    writeString('fmt ');
    writeUint32(16); // PCM chunk size
    writeUint16(1); // PCM format
    writeUint16(channels);
    writeUint32(sampleRate);
    writeUint32(sampleRate * channels * bytesPerSample);
    writeUint16(channels * bytesPerSample);
    writeUint16(8 * bytesPerSample);
    writeString('data');
    writeUint32(byteCount);

    final out = BytesBuilder();
    out.add(header.toBytes());
    out.add(pcmBytes);
    return out.toBytes();
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