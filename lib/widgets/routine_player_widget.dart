import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/routine_player.dart';
import '../widgets/stick_figure_animation.dart';

class RoutinePlayerWidget extends ConsumerWidget {
  final StateNotifierProvider<RoutinePlayerService, RoutinePlayerState> playerProvider;
  final bool isProjectorMode;

  const RoutinePlayerWidget({
    super.key,
    required this.playerProvider,
    this.isProjectorMode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerProvider);
    
    if (isProjectorMode) {
      return _buildProjectorView(context, ref, playerState);
    } else {
      return _buildControllerView(context, ref, playerState);
    }
  }

  Widget _buildProjectorView(BuildContext context, WidgetRef ref, RoutinePlayerState state) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              // Header with routine info
              _buildHeader(context, state),
              const SizedBox(height: 32),
              
              // Main content area
              Expanded(
                child: Row(
                  children: [
                    // Left side - Animation
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Stick figure animation
                            StickFigureAnimationWidget(
                              keyframesJson: state.currentMove?.keyframes,
                              isPlaying: state.playerState == PlayerState.playing,
                              size: 300,
                              color: Colors.white,
                              speed: _getAnimationSpeed(state.blocks.isNotEmpty 
                                ? state.blocks[state.currentBlockIndex].intensity 
                                : 'moderate'),
                            ),
                            const SizedBox(height: 24),
                            
                            // Move name
                            Text(
                              state.currentMove?.name ?? 'Ready',
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 48,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    const SizedBox(width: 32),
                    
                    // Right side - Timer and info
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Progress ring with timer
                          _buildProgressRing(context, state),
                          const SizedBox(height: 32),
                          
                          // Current caption
                          _buildCaption(context, state),
                          const SizedBox(height: 24),
                          
                          // Next move preview
                          if (state.nextMove != null) ...[
                            Text(
                              'NEXT UP:',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white70,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.nextMove!.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              
              // Bottom controls (minimal for projector)
              _buildProjectorControls(context, ref, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControllerView(BuildContext context, WidgetRef ref, RoutinePlayerState state) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine Player'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Progress bar
              _buildProgressBar(context, state),
              const SizedBox(height: 24),
              
              // Timer and animation
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animation
                    StickFigureAnimationWidget(
                      keyframesJson: state.currentMove?.keyframes,
                      isPlaying: state.playerState == PlayerState.playing,
                      size: 200,
                      speed: _getAnimationSpeed(state.blocks.isNotEmpty 
                        ? state.blocks[state.currentBlockIndex].intensity 
                        : 'moderate'),
                    ),
                    const SizedBox(height: 24),
                    
                    // Timer
                    Text(
                      _formatTime(state.remainingSeconds),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 72,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Move name
                    Text(
                      state.currentMove?.name ?? 'Ready',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    
                    // Caption
                    _buildCaption(context, state),
                  ],
                ),
              ),
              
              // Controls
              _buildControllerControls(context, ref, state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, RoutinePlayerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Warm-Up Routine',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${state.currentBlockIndex + 1} of ${state.blocks.length}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressRing(BuildContext context, RoutinePlayerState state) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        children: [
          // Background ring
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 8,
              backgroundColor: Colors.white12,
              valueColor: const AlwaysStoppedAnimation(Colors.transparent),
            ),
          ),
          
          // Progress ring
          SizedBox.expand(
            child: CircularProgressIndicator(
              value: state.progress,
              strokeWidth: 8,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation(
                state.isTransitioning ? Colors.orange : Colors.blue,
              ),
            ),
          ),
          
          // Timer in center
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(state.remainingSeconds),
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 48,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_formatTime(state.progressSeconds)} / ${_formatTime(state.totalRoutineSeconds)}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context, RoutinePlayerState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${state.currentBlockIndex + 1} of ${state.blocks.length}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '${_formatTime(state.progressSeconds)} / ${_formatTime(state.totalRoutineSeconds)}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: state.progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation(
            state.isTransitioning ? Colors.orange : Colors.blue,
          ),
        ),
      ],
    );
  }

  Widget _buildCaption(BuildContext context, RoutinePlayerState state) {
    if (state.currentCaption == null || state.currentCaption!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isProjectorMode ? Colors.white24 : Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        state.currentCaption!,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          color: isProjectorMode ? Colors.white : Colors.blue[800],
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildProjectorControls(BuildContext context, WidgetRef ref, RoutinePlayerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildControlButton(
          context,
          icon: state.playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow,
          onPressed: () {
            if (state.playerState == PlayerState.playing) {
              ref.read(playerProvider.notifier).pause();
            } else {
              ref.read(playerProvider.notifier).play();
            }
          },
          size: 64,
        ),
      ],
    );
  }

  Widget _buildControllerControls(BuildContext context, WidgetRef ref, RoutinePlayerState state) {
    return Column(
      children: [
        // Main controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlButton(
              context,
              icon: Icons.skip_previous,
              onPressed: state.currentBlockIndex > 0
                ? () => ref.read(playerProvider.notifier).skipToPrevious()
                : null,
            ),
            _buildControlButton(
              context,
              icon: state.playerState == PlayerState.playing ? Icons.pause : Icons.play_arrow,
              onPressed: () {
                if (state.playerState == PlayerState.playing) {
                  ref.read(playerProvider.notifier).pause();
                } else {
                  ref.read(playerProvider.notifier).play();
                }
              },
              isPrimary: true,
            ),
            _buildControlButton(
              context,
              icon: Icons.skip_next,
              onPressed: state.currentBlockIndex < state.blocks.length - 1
                ? () => ref.read(playerProvider.notifier).skipToNext()
                : null,
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Secondary controls
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildControlButton(
              context,
              icon: Icons.restart_alt,
              onPressed: () => ref.read(playerProvider.notifier).restart(),
            ),
            _buildControlButton(
              context,
              icon: Icons.add,
              label: '+15s',
              onPressed: () => ref.read(playerProvider.notifier).extendCurrentBlock(15),
            ),
            _buildControlButton(
              context,
              icon: Icons.stop,
              onPressed: () => ref.read(playerProvider.notifier).stop(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildControlButton(
    BuildContext context, {
    required IconData icon,
    VoidCallback? onPressed,
    String? label,
    bool isPrimary = false,
    double size = 48,
  }) {
    final isEnabled = onPressed != null;
    
    return SizedBox(
      width: size + 16,
      height: size + 16,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPrimary 
                ? (isEnabled ? Colors.blue : Colors.grey) 
                : Colors.transparent,
              border: isPrimary 
                ? null 
                : Border.all(
                    color: isEnabled ? Colors.blue : Colors.grey,
                    width: 2,
                  ),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: size * 0.5,
                color: isPrimary 
                  ? Colors.white 
                  : (isEnabled ? Colors.blue : Colors.grey),
              ),
            ),
          ),
          if (label != null) ...[
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isEnabled ? Colors.blue : Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  double _getAnimationSpeed(String intensity) {
    switch (intensity) {
      case 'easy':
        return 0.8;
      case 'spicy':
        return 1.3;
      default: // moderate
        return 1.0;
    }
  }
}