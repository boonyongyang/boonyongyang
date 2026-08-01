import 'package:boonyongyang/core/di/service_locator.dart';
import 'package:boonyongyang/core/routes/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  final directRoutes = [
    '/maps',
    '/charts',
    '/charts/candle',
    '/labs',
    '/plays',
    '/plays/connect4',
    '/plays/tic-tac-toe',
    '/plays/snake',
    '/plays/brick-breaker',
    '/about',
  ];

  setUp(() async {
    await getIt.reset();
    setupServiceLocator();
  });

  tearDown(() async {
    await getIt.reset();
  });

  for (final path in directRoutes) {
    testWidgets('preserves $path as the browser entry route', (tester) async {
      tester.binding.platformDispatcher.defaultRouteNameTestValue = path;
      addTearDown(
        tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
      );

      final router = AppRouter.config as GoRouter;
      addTearDown(router.dispose);

      expect(router.routeInformationProvider.value.uri.path, path);
    });
  }

  test('declares every public direct route once', () {
    expect(
      AppRouter.routes.values.map((route) => route.path),
      containsAll(directRoutes),
    );
    expect(AppRouter.routes.values.map((route) => route.path).toSet().length,
        AppRouter.routes.length);
  });
}
