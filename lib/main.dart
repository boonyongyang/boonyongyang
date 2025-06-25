import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'apps/app_config.dart';
import 'apps/landing/landing_app.dart';
import 'apps/main_app/main_app.dart';
import 'core/di/service_locator.dart';
import 'core/providers/performance_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Only initialize services for main app
  if (AppConfig.isMainApp) {
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
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Determine which app to run based on configuration
    if (AppConfig.isLanding) {
      return const LandingApp();
    } else {
      return const MainApp();
    }
  }
}
