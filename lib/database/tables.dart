import 'package:drift/drift.dart';

enum SpaceType {
  fullGym,
  halfGym,
  hallway,
  classroom,
  courtyard,
}

enum Equipment {
  none,
  cones,
  balls,
  ropes,
  hullahoop,
}

enum ImpactLevel {
  low,
  moderate,
  high,
}

enum NoiseLevel {
  quiet,
  moderate,
  loud,
}

enum GradeBand {
  k2,
  grades3to5,
  grades6to8,
}

enum RoutineType {
  mobility,
  cardio,
  mixed,
}

@DataClassName('Move')
class Moves extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get tags => text()(); // JSON array as string
  IntColumn get gradeMin => integer()(); // 0-8 (K=0, 1st=1, etc.)
  IntColumn get gradeMax => integer()(); // 0-8
  IntColumn get needsSpace => intEnum<SpaceType>()();
  TextColumn get needsEquipment => text()(); // JSON array of Equipment enum values
  IntColumn get impact => intEnum<ImpactLevel>()();
  IntColumn get noise => intEnum<NoiseLevel>()();
  BoolColumn get allowFloor => boolean().withDefault(const Constant(true))();
  IntColumn get defaultDurationS => integer().withDefault(const Constant(30))();
  TextColumn get keyframes => text().nullable()(); // JSON string
  TextColumn get lottieAssetPath => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Routine')
class Routines extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  IntColumn get totalSeconds => integer()();
  TextColumn get blocksJson => text()(); // JSON array of routine blocks
  BoolColumn get isFavorite => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Preset')
class Presets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get gradeBand => intEnum<GradeBand>()();
  IntColumn get space => intEnum<SpaceType>()();
  TextColumn get equipment => text()(); // JSON array of Equipment enum values
  IntColumn get type => intEnum<RoutineType>()();
  IntColumn get lengthS => integer()();
  TextColumn get constraintsJson => text()(); // JSON object with additional constraints
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Session')
class Sessions extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get routineId => integer().references(Routines, #id)();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime().nullable()();
  TextColumn get notesJson => text().nullable()(); // JSON object with session feedback
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('Setting')
class Settings extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get key => text().withLength(min: 1, max: 100).unique()();
  TextColumn get valueJson => text()(); // JSON value
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

@DataClassName('VoicePack')
class VoicePacks extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get locale => text().withLength(min: 2, max: 10)();
  RealColumn get speed => real().withDefault(const Constant(1.0))();
  RealColumn get pitch => real().withDefault(const Constant(1.0))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}