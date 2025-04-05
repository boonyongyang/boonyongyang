import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'page_transitions.dart';
import '../theme/color_palette.dart';

import '../../features/about/view/about_page.dart';
import '../../features/charts/view/charts_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/labs/view/labs_page.dart';
import '../../features/maps/view/maps_page.dart';
import '../../features/plays/view/plays_page.dart';
import '../../features/plays/view/connect4_view.dart';
import '../../features/plays/view/ai_tic_tac_toe_view.dart';
import '../../features/plays/view/snake_game_view.dart';
import '../../features/plays/view/brick_breaker_view.dart';
import '../di/service_locator.dart';
import '../providers/navigation_state.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final Map<String, ({String path, String name})> routes = {
    'home': (path: '/', name: 'home'),
    'maps': (path: '/maps', name: 'maps'),
    'charts': (path: '/charts', name: 'charts'),
    'labs': (path: '/labs', name: 'labs'),
    'plays': (path: '/plays', name: 'plays'),
    'connect4': (path: '/plays/connect4', name: 'connect4'),
    'ticTacToe': (path: '/plays/tic-tac-toe', name: 'ticTacToe'),
    'snake': (path: '/plays/snake', name: 'snake'),
    'brickBreaker': (path: '/plays/brick-breaker', name: 'brickBreaker'),
    'about': (path: '/about', name: 'about'),
  };

  static RouterConfig<Object> get config => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: routes['home']!.path,
        restorationScopeId: 'app_router',
        observers: [_NavigationObserver()],
        routes: [
          GoRoute(
            path: routes['home']!.path,
            name: routes['home']!.name,
            pageBuilder: (context, state) => buildPageWithTransition(
              child: const HomePage(),
              name: state.name,
              arguments: state.extra,
              restorationId: state.pageKey.value,
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: routes['maps']!.path,
            name: routes['maps']!.name,
            pageBuilder: (context, state) => buildPageWithTransition(
              child: const MapsPage(),
              name: state.name,
              arguments: state.extra,
              restorationId: state.pageKey.value,
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: routes['charts']!.path,
            name: routes['charts']!.name,
            pageBuilder: (context, state) => buildPageWithTransition(
              child: const ChartsPage(),
              name: state.name,
              arguments: state.extra,
              restorationId: state.pageKey.value,
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: routes['labs']!.path,
            name: routes['labs']!.name,
            pageBuilder: (context, state) => buildPageWithTransition(
              child: const LabsPage(),
              name: state.name,
              arguments: state.extra,
              restorationId: state.pageKey.value,
              key: state.pageKey,
            ),
          ),
          GoRoute(
            path: routes['plays']!.path,
            name: routes['plays']!.name,
            pageBuilder: (context, state) => buildPageWithTransition(
              child: const PlaysPage(),
              name: state.name,
              arguments: state.extra,
              restorationId: state.pageKey.value,
              key: state.pageKey,
            ),
            routes: [
              GoRoute(
                path: 'connect4',
                name: routes['connect4']!.name,
                pageBuilder: (context, state) => buildPageWithTransition(
                  child: const Connect4View(),
                  name: state.name,
                  arguments: state.extra,
                  restorationId: state.pageKey.value,
                  key: state.pageKey,
                ),
              ),
              GoRoute(
                path: 'tic-tac-toe',
                name: routes['ticTacToe']!.name,
                pageBuilder: (context, state) => buildPageWithTransition(
                  child: const AITicTacToeView(),
                  name: state.name,
                  arguments: state.extra,
                  restorationId: state.pageKey.value,
                  key: state.pageKey,
                ),
              ),
              GoRoute(
                path: 'snake',
                name: routes['snake']!.name,
                pageBuilder: (context, state) => buildPageWithTransition(
                  child: const SnakeGameView(),
                  name: state.name,
                  arguments: state.extra,
                  restorationId: state.pageKey.value,
                  key: state.pageKey,
                ),
              ),
              GoRoute(
                path: 'brick-breaker',
                name: routes['brickBreaker']!.name,
                pageBuilder: (context, state) => buildPageWithTransition(
                  child: const BrickBreakerView(),
                  name: state.name,
                  arguments: state.extra,
                  restorationId: state.pageKey.value,
                  key: state.pageKey,
                ),
              ),
            ],
          ),
          GoRoute(
            path: routes['about']!.path,
            name: routes['about']!.name,
            pageBuilder: (context, state) => buildPageWithTransition(
              child: const AboutPage(),
              name: state.name,
              arguments: state.extra,
              restorationId: state.pageKey.value,
              key: state.pageKey,
            ),
          ),
        ],
        errorBuilder: (context, state) => _buildErrorPage(context),
      );

  static Widget _buildErrorPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Container(
        decoration: BoxDecoration(
          color: ColorPalette.darkBackground,
          gradient: ColorPalette.heroGradient,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) =>
                    ColorPalette.titleGradient.createShader(bounds),
                child: Text(
                  'Path not found',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).primaryColor,
                      Theme.of(context).primaryColor.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () => context.go(routes['home']!.path),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text('Go Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavigationObserver extends NavigatorObserver {
  final _navigationState = getIt<NavigationState>();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _updateNavigationState(route);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) _updateNavigationState(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) _updateNavigationState(previousRoute);
  }

  void _updateNavigationState(Route<dynamic> route) {
    final settings = route.settings;
    final String path;

    if (settings.name != null) {
      path = settings.name!;
    } else {
      path = '/';
    }

    _navigationState.updatePath(path);
  }
}
