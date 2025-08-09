import 'package:drift/drift.dart';
import 'package:drift/web.dart';

QueryExecutor openConnection() {
  // Use IndexedDB on the web
  return WebDatabase('warm_up_wizard');
}
