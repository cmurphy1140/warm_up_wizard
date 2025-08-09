import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../database/tables.dart';
import '../models/routine_models.dart';
import '../services/routine_generator.dart';

class HomeScreenFilter {
  final GradeBand gradeBand;
  final SpaceType spaceType;
  final List<Equipment> equipment;
  final RoutineType routineType;
  final int durationMinutes;
  final RoutineConstraints constraints;

  const HomeScreenFilter({
    this.gradeBand = GradeBand.k2,
    this.spaceType = SpaceType.classroom,
    this.equipment = const [Equipment.none],
    this.routineType = RoutineType.mixed,
    this.durationMinutes = 5,
    this.constraints = const RoutineConstraints(),
  });

  HomeScreenFilter copyWith({
    GradeBand? gradeBand,
    SpaceType? spaceType,
    List<Equipment>? equipment,
    RoutineType? routineType,
    int? durationMinutes,
    RoutineConstraints? constraints,
  }) {
    return HomeScreenFilter(
      gradeBand: gradeBand ?? this.gradeBand,
      spaceType: spaceType ?? this.spaceType,
      equipment: equipment ?? this.equipment,
      routineType: routineType ?? this.routineType,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      constraints: constraints ?? this.constraints,
    );
  }
}

final homeFilterProvider = StateProvider<HomeScreenFilter>((ref) => const HomeScreenFilter());

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(homeFilterProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Warm-Up Wizard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Create Your Warm-Up',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Customize settings and tap Start for a randomized routine',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Filters
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildGradeBandSelector(context, ref, filter),
                      const SizedBox(height: 24),
                      _buildSpaceSelector(context, ref, filter),
                      const SizedBox(height: 24),
                      _buildEquipmentSelector(context, ref, filter),
                      const SizedBox(height: 24),
                      _buildRoutineTypeSelector(context, ref, filter),
                      const SizedBox(height: 24),
                      _buildDurationSelector(context, ref, filter),
                      const SizedBox(height: 24),
                      _buildConstraintsSection(context, ref, filter),
                    ],
                  ),
                ),
              ),
              
              // Action buttons
              const SizedBox(height: 24),
              _buildActionButtons(context, ref, filter),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradeBandSelector(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return _buildSelectorCard(
      context,
      title: 'Grade Band',
      child: SegmentedButton<GradeBand>(
        segments: const [
          ButtonSegment(
            value: GradeBand.k2,
            label: Text('K-2'),
          ),
          ButtonSegment(
            value: GradeBand.grades3to5,
            label: Text('3-5'),
          ),
          ButtonSegment(
            value: GradeBand.grades6to8,
            label: Text('6-8'),
          ),
        ],
        selected: {filter.gradeBand},
        onSelectionChanged: (selection) {
          ref.read(homeFilterProvider.notifier).update((state) =>
              state.copyWith(gradeBand: selection.first));
        },
      ),
    );
  }

  Widget _buildSpaceSelector(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return _buildSelectorCard(
      context,
      title: 'Available Space',
      child: Wrap(
        spacing: 8,
        children: SpaceType.values.map((space) {
          final isSelected = filter.spaceType == space;
          return FilterChip(
            label: Text(_getSpaceLabel(space)),
            selected: isSelected,
            onSelected: (selected) {
              if (selected) {
                ref.read(homeFilterProvider.notifier).update((state) =>
                    state.copyWith(spaceType: space));
              }
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEquipmentSelector(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return _buildSelectorCard(
      context,
      title: 'Available Equipment',
      child: Wrap(
        spacing: 8,
        children: Equipment.values.map((equipment) {
          final isSelected = filter.equipment.contains(equipment);
          return FilterChip(
            label: Text(_getEquipmentLabel(equipment)),
            selected: isSelected,
            onSelected: (selected) {
              List<Equipment> newEquipment;
              if (selected) {
                newEquipment = [...filter.equipment];
                if (!newEquipment.contains(equipment)) {
                  newEquipment.add(equipment);
                }
                // Remove 'none' if other equipment is selected
                if (equipment != Equipment.none && newEquipment.contains(Equipment.none)) {
                  newEquipment.remove(Equipment.none);
                }
              } else {
                newEquipment = filter.equipment.where((e) => e != equipment).toList();
                // Add 'none' if no equipment is selected
                if (newEquipment.isEmpty) {
                  newEquipment.add(Equipment.none);
                }
              }
              ref.read(homeFilterProvider.notifier).update((state) =>
                  state.copyWith(equipment: newEquipment));
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRoutineTypeSelector(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return _buildSelectorCard(
      context,
      title: 'Routine Focus',
      child: SegmentedButton<RoutineType>(
        segments: const [
          ButtonSegment(
            value: RoutineType.mobility,
            label: Text('Mobility'),
            icon: Icon(Icons.accessibility_new),
          ),
          ButtonSegment(
            value: RoutineType.cardio,
            label: Text('Cardio'),
            icon: Icon(Icons.favorite),
          ),
          ButtonSegment(
            value: RoutineType.mixed,
            label: Text('Mixed'),
            icon: Icon(Icons.tune),
          ),
        ],
        selected: {filter.routineType},
        onSelectionChanged: (selection) {
          ref.read(homeFilterProvider.notifier).update((state) =>
              state.copyWith(routineType: selection.first));
        },
      ),
    );
  }

  Widget _buildDurationSelector(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return _buildSelectorCard(
      context,
      title: 'Duration: ${filter.durationMinutes} minutes',
      child: Slider(
        value: filter.durationMinutes.toDouble(),
        min: 2,
        max: 10,
        divisions: 8,
        label: '${filter.durationMinutes} min',
        onChanged: (value) {
          ref.read(homeFilterProvider.notifier).update((state) =>
              state.copyWith(durationMinutes: value.round()));
        },
      ),
    );
  }

  Widget _buildConstraintsSection(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return _buildSelectorCard(
      context,
      title: 'Constraints',
      child: Column(
        children: [
          SwitchListTile(
            title: const Text('No Floor Exercises'),
            subtitle: const Text('Avoid moves that require getting on the floor'),
            value: filter.constraints.noFloor,
            onChanged: (value) {
              ref.read(homeFilterProvider.notifier).update((state) => state.copyWith(
                constraints: filter.constraints.copyWith(noFloor: value),
              ));
            },
          ),
          SwitchListTile(
            title: const Text('Classroom Tight'),
            subtitle: const Text('Desk-friendly moves only'),
            value: filter.constraints.classroomTight,
            onChanged: (value) {
              ref.read(homeFilterProvider.notifier).update((state) => state.copyWith(
                constraints: filter.constraints.copyWith(classroomTight: value),
              ));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    return Column(
      children: [
        // Main Start button
        SizedBox(
          width: double.infinity,
          height: 64,
          child: ElevatedButton(
            onPressed: () => _startRoutine(context, ref, filter),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.play_arrow, size: 32),
                const SizedBox(width: 12),
                Text(
                  'START ROUTINE',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Secondary buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _shuffleAndStart(context, ref, filter),
                icon: const Icon(Icons.shuffle),
                label: const Text('SHUFFLE'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.push('/favorites'),
                icon: const Icon(Icons.favorite),
                label: const Text('FAVORITES'),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        // Additional buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.push('/library'),
                icon: const Icon(Icons.library_books),
                label: const Text('LIBRARY'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => context.push('/export'),
                icon: const Icon(Icons.share),
                label: const Text('EXPORT'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSelectorCard(BuildContext context, {required String title, required Widget child}) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  String _getSpaceLabel(SpaceType space) {
    switch (space) {
      case SpaceType.fullGym:
        return 'Full Gym';
      case SpaceType.halfGym:
        return 'Half Gym';
      case SpaceType.hallway:
        return 'Hallway';
      case SpaceType.classroom:
        return 'Classroom';
      case SpaceType.courtyard:
        return 'Courtyard';
    }
  }

  String _getEquipmentLabel(Equipment equipment) {
    switch (equipment) {
      case Equipment.none:
        return 'None';
      case Equipment.cones:
        return 'Cones';
      case Equipment.balls:
        return 'Balls';
      case Equipment.ropes:
        return 'Ropes';
      case Equipment.hullahoop:
        return 'Hula Hoops';
    }
  }

  void _startRoutine(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    // Navigate to routine generation and then player
    context.push('/generate-routine', extra: _createGenerationRequest(filter));
  }

  void _shuffleAndStart(BuildContext context, WidgetRef ref, HomeScreenFilter filter) {
    // Could randomize some settings before starting
    _startRoutine(context, ref, filter);
  }

  RoutineGenerationRequest _createGenerationRequest(HomeScreenFilter filter) {
    return RoutineGenerationRequest(
      gradeBand: filter.gradeBand,
      space: filter.spaceType,
      equipment: filter.equipment,
      type: filter.routineType,
      targetLengthSeconds: filter.durationMinutes * 60,
      constraints: filter.constraints,
    );
  }
}