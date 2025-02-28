import 'package:get_it/get_it.dart';
import '../providers/navigation_state.dart';
import '../providers/performance_config.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register services as singletons
  getIt.registerLazySingleton(() => NavigationState());
  getIt.registerLazySingleton(() => PerformanceConfig());
}
