// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineBlock _$RoutineBlockFromJson(Map<String, dynamic> json) => RoutineBlock(
  moveId: json['moveId'] as String,
  seconds: (json['seconds'] as num).toInt(),
  intensity: json['intensity'] as String,
);

Map<String, dynamic> _$RoutineBlockToJson(RoutineBlock instance) =>
    <String, dynamic>{
      'moveId': instance.moveId,
      'seconds': instance.seconds,
      'intensity': instance.intensity,
    };

MoveKeyframe _$MoveKeyframeFromJson(Map<String, dynamic> json) => MoveKeyframe(
  id: json['id'] as String,
  jointAngles: (json['jointAngles'] as Map<String, dynamic>).map(
    (k, e) => MapEntry(k, (e as num).toDouble()),
  ),
  description: json['description'] as String?,
);

Map<String, dynamic> _$MoveKeyframeToJson(MoveKeyframe instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jointAngles': instance.jointAngles,
      'description': instance.description,
    };

MovePose _$MovePoseFromJson(Map<String, dynamic> json) => MovePose(
  name: json['name'] as String,
  keyframes: (json['keyframes'] as List<dynamic>)
      .map((e) => MoveKeyframe.fromJson(e as Map<String, dynamic>))
      .toList(),
  durationMs: (json['durationMs'] as num).toInt(),
  easing: json['easing'] as String? ?? "ease-in-out",
);

Map<String, dynamic> _$MovePoseToJson(MovePose instance) => <String, dynamic>{
  'name': instance.name,
  'keyframes': instance.keyframes,
  'durationMs': instance.durationMs,
  'easing': instance.easing,
};

SessionNote _$SessionNoteFromJson(Map<String, dynamic> json) => SessionNote(
  type: json['type'] as String,
  value: json['value'] as String,
  comment: json['comment'] as String?,
  timestamp: json['timestamp'] == null
      ? null
      : DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$SessionNoteToJson(SessionNote instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'comment': instance.comment,
      'timestamp': instance.timestamp.toIso8601String(),
    };

RoutineConstraints _$RoutineConstraintsFromJson(Map<String, dynamic> json) =>
    RoutineConstraints(
      noFloor: json['noFloor'] as bool? ?? false,
      maxNoise: (json['maxNoise'] as num?)?.toInt() ?? 2,
      maxImpact: (json['maxImpact'] as num?)?.toInt() ?? 2,
      excludeMoves:
          (json['excludeMoves'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      preferMoves:
          (json['preferMoves'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      classroomTight: json['classroomTight'] as bool? ?? false,
    );

Map<String, dynamic> _$RoutineConstraintsToJson(RoutineConstraints instance) =>
    <String, dynamic>{
      'noFloor': instance.noFloor,
      'maxNoise': instance.maxNoise,
      'maxImpact': instance.maxImpact,
      'excludeMoves': instance.excludeMoves,
      'preferMoves': instance.preferMoves,
      'classroomTight': instance.classroomTight,
    };
