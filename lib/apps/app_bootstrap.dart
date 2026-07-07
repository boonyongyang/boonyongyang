import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/di/service_locator.dart';
import '../core/providers/performance_config.dart';

/// Runs a Flutter entrypoint with shared error handling and optional services.
void bootstrapApp({
  required Widget app,
  required bool initializeMainServices,
}) {
  runZonedGuarded(
    () {
      WidgetsFlutterBinding.ensureInitialized();

      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        debugPrint('FlutterError: ${details.exceptionAsString()}');
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        debugPrint('PlatformError: $error\n$stack');
        return true;
      };

      if (initializeMainServices) {
        setupServiceLocator();
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
          ),
        );
        debugPrintRebuildDirtyWidgets = false;
        getIt<PerformanceConfig>().optimizeForDevice();
      }

      runApp(app);
    },
    (error, stack) {
      debugPrint('Unhandled error: $error\n$stack');
    },
  );
}
