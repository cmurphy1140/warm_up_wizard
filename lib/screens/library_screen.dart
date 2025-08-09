import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database.dart';
import '../database/tables.dart';
import '../widgets/stick_figure_animation.dart';
import '../providers.dart';

class LibraryScreen extends ConsumerStatefulWidget {
  const LibraryScreen({super.key});

  @override
  ConsumerState<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends ConsumerState<LibraryScreen> {
  String _searchQuery = '';
  String _selectedTag = 'All';
  List<Move> _allMoves = [];
  List<Move> _filteredMoves = [];
  final Set<String> _allTags = {'All'};

  @override
  void initState() {
    super.initState();
    _loadMoves();
  }

  Future<void> _loadMoves() async {
    final moveService = ref.read(moveServiceProvider);
    final moves = await moveService.getAllMoves();
    final tags = <String>{};
    for (final m in moves) {
      final mtags = List<String>.from(jsonDecode(m.tags));
      tags.addAll(mtags.map((t) => _formatTag(t)));
    }
    setState(() {
      _allMoves = moves;
      _filteredMoves = _allMoves;
      _allTags
        ..clear()
        ..add('All')
        ..addAll(tags.toList()..sort());
    });
  }

  void _updateFilters() {
    setState(() {
      _filteredMoves = _allMoves.where((move) {
        // Search filter
        if (_searchQuery.isNotEmpty) {
          final query = _searchQuery.toLowerCase();
          if (!move.name.toLowerCase().contains(query)) {
            final tags = List<String>.from(jsonDecode(move.tags));
            if (!tags.any((tag) => tag.toLowerCase().contains(query))) {
              return false;
            }
          }
        }

        // Tag filter
        if (_selectedTag != 'All') {
          final tags = List<String>.from(jsonDecode(move.tags));
          if (!tags.contains(_selectedTag.toLowerCase())) {
            return false;
          }
        }

        return true;
      }).toList();
    });
  }

  String _formatTag(String tag) {
    final withSpaces = tag.replaceAll('_', ' ');
    return withSpaces.isEmpty
        ? withSpaces
        : withSpaces[0].toUpperCase() + withSpaces.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Move Library'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search moves...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (query) {
                    _searchQuery = query;
                    _updateFilters();
                  },
                ),
              ),
              
              // Tag filter
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _allTags.length,
                  itemBuilder: (context, index) {
                    final tag = _allTags.elementAt(index);
                    final isSelected = _selectedTag == tag;
                    
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(tag),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedTag = tag;
                          });
                          _updateFilters();
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: _filteredMoves.isEmpty
          ? _buildEmptyState(context)
          : _buildMoveList(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty || _selectedTag != 'All'
                ? 'No moves match your filters'
                : 'Loading moves...',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty || _selectedTag != 'All'
                ? 'Try adjusting your search or filters'
                : 'Please wait while we load the move library',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoveList(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _filteredMoves.length,
      itemBuilder: (context, index) {
        final move = _filteredMoves[index];
        return _buildMoveCard(context, move);
      },
    );
  }

  Widget _buildMoveCard(BuildContext context, Move move) {
    final tags = List<String>.from(jsonDecode(move.tags));
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: _getImpactColor(move.impact).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              _getEquipmentIcon(move.needsEquipment),
              color: _getImpactColor(move.impact),
            ),
          ),
        ),
        title: Text(
          move.name,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                _buildInfoChip(
                  context,
                  '${move.defaultDurationS}s',
                  Icons.timer,
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  context,
                  _getImpactLabel(move.impact),
                  Icons.fitness_center,
                  color: _getImpactColor(move.impact),
                ),
                const SizedBox(width: 8),
                _buildInfoChip(
                  context,
                  _getSpaceLabel(move.needsSpace),
                  Icons.place,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 4,
              runSpacing: 4,
              children: tags.take(3).map((tag) => Chip(
                label: Text(
                  tag.replaceAll('_', ' '),
                  style: const TextStyle(fontSize: 12),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              )).toList(),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Animation preview
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: StickFigureAnimationWidget(
                    keyframesJson: move.keyframes,
                    size: 120,
                    isPlaying: true,
                  ),
                ),
                const SizedBox(width: 16),
                
                // Move details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Details',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildDetailRow(
                        context,
                        'Grade Range',
                        'K-${move.gradeMax == 0 ? 'K' : move.gradeMax}',
                      ),
                      _buildDetailRow(
                        context,
                        'Impact Level',
                        _getImpactLabel(move.impact),
                      ),
                      _buildDetailRow(
                        context,
                        'Noise Level',
                        _getNoiseLabel(move.noise),
                      ),
                      _buildDetailRow(
                        context,
                        'Floor Exercise',
                        move.allowFloor ? 'Yes' : 'No',
                      ),
                      const SizedBox(height: 8),
                      if (tags.isNotEmpty) ...[
                        Text(
                          'Tags',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          children: tags.map((tag) => Chip(
                            label: Text(
                              tag.replaceAll('_', ' '),
                              style: const TextStyle(fontSize: 11),
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          )).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    String label,
    IconData icon, {
    Color? color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (color ?? Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: color ?? Colors.grey[700],
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: color ?? Colors.grey[700],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Color _getImpactColor(ImpactLevel impact) {
    switch (impact) {
      case ImpactLevel.low:
        return Colors.green;
      case ImpactLevel.moderate:
        return Colors.orange;
      case ImpactLevel.high:
        return Colors.red;
    }
  }

  String _getImpactLabel(ImpactLevel impact) {
    switch (impact) {
      case ImpactLevel.low:
        return 'Low';
      case ImpactLevel.moderate:
        return 'Moderate';
      case ImpactLevel.high:
        return 'High';
    }
  }

  String _getNoiseLabel(NoiseLevel noise) {
    switch (noise) {
      case NoiseLevel.quiet:
        return 'Quiet';
      case NoiseLevel.moderate:
        return 'Moderate';
      case NoiseLevel.loud:
        return 'Loud';
    }
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

  IconData _getEquipmentIcon(String equipmentJson) {
    try {
      final List<String> equipment = List<String>.from(jsonDecode(equipmentJson));
      if (equipment.contains('balls')) return Icons.sports_basketball;
      if (equipment.contains('cones')) return Icons.traffic;
      if (equipment.contains('ropes')) return Icons.linear_scale;
      if (equipment.contains('hullahoop')) return Icons.radio_button_unchecked;
      return Icons.accessibility_new;
    } catch (e) {
      return Icons.accessibility_new;
    }
  }
}