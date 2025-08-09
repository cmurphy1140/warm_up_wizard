import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../screens/home_screen.dart';
import '../screens/library_screen.dart';
import '../screens/settings_screen.dart';
import '../services/routine_generator.dart';
import '../models/routine_models.dart';
import '../providers.dart';
import '../widgets/routine_player_widget.dart';
import '../services/routine_player.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/library',
      name: 'library',
      builder: (context, state) => const LibraryScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/generate-routine',
      name: 'generate-routine',
      builder: (context, state) {
        final request = state.extra as RoutineGenerationRequest?;
        return RoutineGenerationScreen(request: request);
      },
    ),
    GoRoute(
      path: '/player',
      name: 'player',
      builder: (context, state) {
        final blocks = state.extra as List<RoutineBlock>?;
        return PlayerScreen(blocks: blocks);
      },
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const FavoritesScreen(),
    ),
    GoRoute(
      path: '/export',
      name: 'export',
      builder: (context, state) => const ExportScreen(),
    ),
  ],
);

class RoutineGenerationScreen extends ConsumerStatefulWidget {
  final RoutineGenerationRequest? request;

  const RoutineGenerationScreen({super.key, this.request});

  @override
  ConsumerState<RoutineGenerationScreen> createState() => _RoutineGenerationScreenState();
}

class _RoutineGenerationScreenState extends ConsumerState<RoutineGenerationScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _generate();
  }

  Future<void> _generate() async {
    final req = widget.request;
    if (req == null) {
      setState(() => _error = 'No request provided');
      return;
    }
    try {
      final moveService = ref.read(moveServiceProvider);
      final generator = RoutineGenerator(moveService);
      final blocks = await generator.generateRoutine(req);
      if (!mounted) return;
      context.go('/player', extra: blocks);
    } catch (e) {
      setState(() => _error = 'Failed to generate routine');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generating Routine...')),
      body: Center(
        child: _error == null
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Creating your personalized routine...'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(height: 8),
                  Text(_error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _generate,
                    child: const Text('Retry'),
                  ),
                ],
              ),
      ),
    );
  }
}

class PlayerScreen extends ConsumerStatefulWidget {
  final List<RoutineBlock>? blocks;
  const PlayerScreen({super.key, this.blocks});

  @override
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late final StateNotifierProvider<RoutinePlayerService, RoutinePlayerState> _playerProvider;

  @override
  void initState() {
    super.initState();
    final moveService = ref.read(moveServiceProvider);
    _playerProvider = routinePlayerProviderWithService(moveService);
    _initPlayer();
  }

  Future<void> _initPlayer() async {
    final blocks = widget.blocks;
    if (blocks == null || blocks.isEmpty) return;
    final notifier = ref.read(_playerProvider.notifier);
    await notifier.loadRoutine(blocks);
    await notifier.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Player')),
      body: widget.blocks == null
          ? const Center(child: Text('No routine provided'))
          : RoutinePlayerWidget(playerProvider: _playerProvider),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: const Center(
        child: Text('Favorites Screen'),
      ),
    );
  }
}

class ExportScreen extends StatelessWidget {
  const ExportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Export')),
      body: const Center(
        child: Text('Export Screen'),
      ),
    );
  }
}