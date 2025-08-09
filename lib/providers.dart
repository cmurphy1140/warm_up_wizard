import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database/database.dart';
import 'services/move_service.dart';

// Providers for dependency injection
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('Database should be overridden in main()');
});

final moveServiceProvider = Provider<MoveService>((ref) {
  throw UnimplementedError('MoveService should be overridden in main()');
});
