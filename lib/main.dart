import 'package:flutter/material.dart';
import 'apps/app_bootstrap.dart';
import 'apps/app_config.dart';
import 'apps/landing/landing_app.dart';
import 'apps/main_app/main_app.dart';

void main() {
  bootstrapApp(
    app: const MyApp(),
    initializeMainServices: AppConfig.isMainApp,
  );
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
