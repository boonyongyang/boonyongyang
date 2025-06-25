import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apps/main_app/main_app.dart';
import 'core/di/service_locator.dart';
import 'core/providers/performance_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize services for main app
  setupServiceLocator();

  // Optimize system UI and performance
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarDividerColor: Colors.transparent,
    ),
  );

  // Enable render profiling in debug mode
  debugPrintRebuildDirtyWidgets = false;

  // Initialize performance settings
  final performanceConfig = getIt<PerformanceConfig>();
  performanceConfig.optimizeForDevice();

  runApp(const MainApp());
}
