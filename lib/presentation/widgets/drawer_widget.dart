import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  final PageController pageController;

  const DrawerWidget({
    super.key,
    required this.pageController,
  });

  void _navigateToPage(int page, BuildContext context) {
    pageController.jumpToPage(page);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Text(
              'want go where ah?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              _navigateToPage(0, context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About'),
            onTap: () {
              _navigateToPage(1, context);
            },
          ),
        ],
      ),
    );
  }
}
