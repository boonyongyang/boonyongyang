import 'package:flutter/material.dart';
import '../../core/di/service_locator.dart';
import '../../core/routes/app_router.dart';
import '../../core/theme/app_theme.dart';
import '../../core/utils/smooth_scroll_behavior.dart';
import '../../core/providers/performance_config.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final performanceConfig = getIt<PerformanceConfig>();

    return AnimatedBuilder(
      animation: performanceConfig,
      builder: (context, _) {
        // Adjust scroll behavior based on performance mode
        final scrollBehavior = SmoothScrollBehavior(
          // Lower friction for high-performance mode (smoother scrolling)
          // Higher friction for low-performance mode (more resistant)
          overscrollFriction:
              performanceConfig.isHighPerformanceMode ? 0.15 : 0.3,
          // Higher damping factor means quicker settling
          overscrollDampingFactor:
              performanceConfig.reduceAnimations ? 1.0 : 0.85,
        );

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Interactive Flutter Web',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.dark,
          scrollBehavior: scrollBehavior,
          routerConfig: AppRouter.config,
        );
      },
    );
  }
}
