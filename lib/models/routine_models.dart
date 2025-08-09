import 'package:json_annotation/json_annotation.dart';

part 'routine_models.g.dart';

@JsonSerializable()
class RoutineBlock {
  final String moveId;
  final int seconds;
  final String intensity; // "easy", "moderate", "spicy"

  const RoutineBlock({
    required this.moveId,
    required this.seconds,
    required this.intensity,
  });

  factory RoutineBlock.fromJson(Map<String, dynamic> json) =>
      _$RoutineBlockFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineBlockToJson(this);
}

@JsonSerializable()
class MoveKeyframe {
  final String id;
  final Map<String, double> jointAngles; // joint_name -> angle_degrees
  final String? description;

  const MoveKeyframe({
    required this.id,
    required this.jointAngles,
    this.description,
  });

  factory MoveKeyframe.fromJson(Map<String, dynamic> json) =>
      _$MoveKeyframeFromJson(json);

  Map<String, dynamic> toJson() => _$MoveKeyframeToJson(this);
}

@JsonSerializable()
class MovePose {
  final String name;
  final List<MoveKeyframe> keyframes;
  final int durationMs;
  final String easing; // "linear", "ease-in", "ease-out", "ease-in-out"

  const MovePose({
    required this.name,
    required this.keyframes,
    required this.durationMs,
    this.easing = "ease-in-out",
  });

  factory MovePose.fromJson(Map<String, dynamic> json) =>
      _$MovePoseFromJson(json);

  Map<String, dynamic> toJson() => _$MovePoseToJson(this);
}

@JsonSerializable()
class SessionNote {
  final String type; // "feedback", "safety", "engagement"
  final String value; // "too_loud", "space_crowded", "loved_it", etc.
  final String? comment;
  final DateTime timestamp;

  SessionNote({
    required this.type,
    required this.value,
    this.comment,
    DateTime? timestamp,
  }) : timestamp = timestamp ?? DateTime.now();

  factory SessionNote.fromJson(Map<String, dynamic> json) =>
      _$SessionNoteFromJson(json);

  Map<String, dynamic> toJson() => _$SessionNoteToJson(this);
}

@JsonSerializable()
class RoutineConstraints {
  final bool noFloor;
  final int maxNoise; // 0=quiet, 1=moderate, 2=loud
  final int maxImpact; // 0=low, 1=moderate, 2=high
  final List<String> excludeMoves; // move IDs to exclude
  final List<String> preferMoves; // move IDs to prefer
  final bool classroomTight; // desk-friendly moves only

  const RoutineConstraints({
    this.noFloor = false,
    this.maxNoise = 2,
    this.maxImpact = 2,
    this.excludeMoves = const [],
    this.preferMoves = const [],
    this.classroomTight = false,
  });

  RoutineConstraints copyWith({
    bool? noFloor,
    int? maxNoise,
    int? maxImpact,
    List<String>? excludeMoves,
    List<String>? preferMoves,
    bool? classroomTight,
  }) {
    return RoutineConstraints(
      noFloor: noFloor ?? this.noFloor,
      maxNoise: maxNoise ?? this.maxNoise,
      maxImpact: maxImpact ?? this.maxImpact,
      excludeMoves: excludeMoves ?? this.excludeMoves,
      preferMoves: preferMoves ?? this.preferMoves,
      classroomTight: classroomTight ?? this.classroomTight,
    );
  }

  factory RoutineConstraints.fromJson(Map<String, dynamic> json) =>
      _$RoutineConstraintsFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineConstraintsToJson(this);
}