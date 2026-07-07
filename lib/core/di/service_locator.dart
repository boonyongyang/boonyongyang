import 'package:dio/dio.dart';
import 'package:dio_intercept_to_curl/dio_intercept_to_curl.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../features/labs/repository/fruit_repository.dart';
import '../../features/labs/services/fruit_service.dart';
import '../providers/navigation_state.dart';
import '../providers/performance_config.dart';

/// Global [GetIt] service locator instance.
final getIt = GetIt.instance;

/// Registers all application-level dependencies.
///
/// Call once at app startup before [runApp].
void setupServiceLocator() {
  // Core
  getIt.registerLazySingleton(() => NavigationState());
  getIt.registerLazySingleton(() => PerformanceConfig());

  // Network
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.addAll([
      DioInterceptToCurl(),
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 120,
      ),
    ]);
    return dio;
  });

  // Repositories
  getIt.registerLazySingleton<FruitRepository>(
    () => FruitService(dio: getIt<Dio>()),
  );
}
