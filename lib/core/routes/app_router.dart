import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/about/view/about_page.dart';
import '../../features/charts/view/charts_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/labs/view/labs_page.dart';
import '../../features/maps/view/maps_page.dart';
import '../../features/plays/view/plays_page.dart';
import '../../features/plays/view/connect4_view.dart';
import '../../features/plays/view/ai_tic_tac_toe_view.dart';
import '../../features/plays/view/snake_game_view.dart';

/// App router configuration using GoRouter
class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/maps',
        name: 'maps',
        builder: (context, state) => const MapsPage(),
      ),
      GoRoute(
        path: '/charts',
        name: 'charts',
        builder: (context, state) => const ChartsPage(),
      ),
      GoRoute(
        path: '/labs',
        name: 'labs',
        builder: (context, state) => const LabsPage(),
      ),
      GoRoute(
        path: '/plays',
        name: 'plays',
        builder: (context, state) => const PlaysPage(),
        routes: [
          GoRoute(
            path: 'connect4',
            name: 'connect4',
            builder: (context, state) => const Connect4View(),
          ),
          GoRoute(
            path: 'tic-tac-toe',
            name: 'ticTacToe',
            builder: (context, state) => const AITicTacToeView(),
          ),
          GoRoute(
            path: 'snake',
            name: 'snake',
            builder: (context, state) => const SnakeGameView(),
          ),
        ],
      ),
      GoRoute(
        path: '/about',
        name: 'about',
        builder: (context, state) => const AboutPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Path not found', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
}
