import 'package:drift/drift.dart';
import 'tables.dart';
import 'connection/connection.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  Moves,
  Routines,
  Presets,
  Sessions,
  Settings,
  VoicePacks,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _insertInitialData();
      },
    );
  }

  Future<void> _insertInitialData() async {
    // Insert default voice pack
    await into(voicePacks).insert(VoicePacksCompanion.insert(
      name: 'Default',
      locale: 'en-US',
      speed: const Value(1.0),
      pitch: const Value(1.0),
    ));

    // Insert default settings
    await into(settings).insert(SettingsCompanion.insert(
      key: 'theme_mode',
      valueJson: '"system"',
    ));
    await into(settings).insert(SettingsCompanion.insert(
      key: 'default_routine_length',
      valueJson: '300',
    ));
    await into(settings).insert(SettingsCompanion.insert(
      key: 'accessibility_high_contrast',
      valueJson: 'false',
    ));
    await into(settings).insert(SettingsCompanion.insert(
      key: 'accessibility_reduced_motion',
      valueJson: 'false',
    ));
  }
}