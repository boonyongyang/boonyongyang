import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const TopNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () => context.go('/'),
        ),
        IconButton(
          icon: const Icon(Icons.map),
          onPressed: () => context.go('/maps'),
        ),
        IconButton(
          icon: const Icon(Icons.show_chart),
          onPressed: () => context.go('/charts'),
        ),
        IconButton(
          icon: const Icon(Icons.science),
          onPressed: () => context.go('/labs'),
        ),
        IconButton(
          icon: const Icon(Icons.games),
          onPressed: () => context.go('/plays'),
        ),
        IconButton(
          icon: const Icon(Icons.info),
          onPressed: () => context.go('/about'),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
