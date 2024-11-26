import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../pages/about_page.dart';
import '../pages/home_page.dart';
import '../pages/labs_page.dart';
import '../pages/plays_page.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key, required this.title});

  final String title;

  void _navigate(BuildContext context, String route) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) {
          return _getPage(route);
        },
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  Widget _getPage(String route) {
    switch (route) {
      case '/plays':
        return const PlaysPage();
      case '/labs':
        return const LabsPage();
      case '/about':
        return const AboutPage();
      default:
        return const HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.bathtub),
        onPressed: () => _navigate(context, '/'),
      ),
      title: Text(title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          )),
      backgroundColor: Colors.grey[100],
      actions: [
        TextButton(
          onPressed: () => _navigate(context, '/'),
          child: const Text('Home'),
        ),
        TextButton(
          onPressed: () => _navigate(context, '/plays'),
          child: const Text('Plays'),
        ),
        TextButton(
          onPressed: () => _navigate(context, '/labs'),
          child: const Text('Labs'),
        ),
        TextButton(
          onPressed: () => _navigate(context, '/about'),
          child: const Text('About'),
        ),
        const Gap(8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
