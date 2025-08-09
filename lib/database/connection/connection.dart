// Platform-conditional database connection factory
// Exports the right connection for web vs io
export 'connection_io.dart' if (dart.library.html) 'connection_web.dart';
