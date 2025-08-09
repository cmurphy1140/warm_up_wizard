import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import 'database/database.dart';
import 'services/move_service.dart';
import 'providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database and load seed moves
  final database = AppDatabase();
  final moveService = MoveService(database);
  await moveService.loadSeedMoves();
  
  runApp(
    ProviderScope(
      overrides: [
        // Provide the database and services to the app
        databaseProvider.overrideWithValue(database),
        moveServiceProvider.overrideWithValue(moveService),
      ],
      child: const WarmUpWizardApp(),
    ),
  );
}

class WarmUpWizardApp extends StatelessWidget {
  const WarmUpWizardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Warm-Up Wizard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        
        // Accessibility-friendly defaults
        textTheme: const TextTheme().apply(
          fontSizeFactor: 1.1, // Slightly larger text
        ),
        
        // Button themes for better touch targets
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(88, 48), // Minimum 48dp height
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(88, 48),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            minimumSize: const Size(88, 48),
          ),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}