import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/di/service_locator.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/smooth_scroll_behavior.dart';
import 'core/providers/performance_config.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // Initialize services
  setupServiceLocator();

  // // Optimize system UI and performance
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     systemNavigationBarColor: Colors.transparent,
  //     systemNavigationBarDividerColor: Colors.transparent,
  //   ),
  // );

  // // Enable render profiling in debug mode
  // debugPrintRebuildDirtyWidgets = false;

  // // Initialize performance settings
  // // final performanceConfig = getIt<PerformanceConfig>();
  // // performanceConfig.optimizeForDevice();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Interactive Flutter Web',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      scrollBehavior: SmoothScrollBehavior(),
      routerConfig: AppRouter.config,
      // builder: (context, child) {
      //   // // Apply performance optimizations
      //   // final performanceConfig = getIt<PerformanceConfig>();

      //   // // Optimize animations based on performance settings
      //   // return AnimatedBuilder(
      //   //   animation: performanceConfig,
      //   //   builder: (context, _) {
      //   return child ?? const CircularProgressIndicator.adaptive();
      //   //   },
      //   // );
      // },
    );
  }
}
