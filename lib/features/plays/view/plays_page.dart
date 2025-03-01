import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/top_nav_bar.dart';

class PlaysPage extends StatelessWidget {
  const PlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;
    final crossAxisCount = switch (screenSize.width) {
      < 600 => 1, // Mobile: 1 column
      < 900 => 2, // Tablet: 2 columns
      < 1200 => 3, // Desktop: 3 columns
      _ => 4, // Large Desktop: 4 columns
    };

    return Scaffold(
      appBar: const TopNavBar(title: 'Games'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Games',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose a game to play',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 24),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth =
                    (constraints.maxWidth - (crossAxisCount - 1) * 16) /
                        crossAxisCount;
                final itemHeight = itemWidth * 0.8;

                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _GameCard(
                      title: 'Snake Battle',
                      description: 'Classic snake game with AI opponent',
                      icon: Icons.sports_esports,
                      color: Colors.green,
                      width: itemWidth,
                      height: itemHeight,
                      onTap: () => context.go('/plays/snake'),
                    ),
                    _GameCard(
                      title: 'Brick Breaker',
                      description: 'Break bricks and collect power-ups',
                      icon: Icons.games,
                      color: Colors.blue,
                      width: itemWidth,
                      height: itemHeight,
                      onTap: () => context.go('/plays/brick-breaker'),
                    ),
                    _GameCard(
                      title: 'AI Tic Tac Toe',
                      description: 'Challenge our unbeatable AI!',
                      icon: Icons.computer,
                      color: Colors.orange,
                      width: itemWidth,
                      height: itemHeight,
                      onTap: () => context.go('/plays/tic-tac-toe'),
                    ),
                    _GameCard(
                      title: 'Connect 4',
                      description: 'Classic two-player connection game',
                      icon: Icons.connect_without_contact,
                      color: Colors.purple,
                      width: itemWidth,
                      height: itemHeight,
                      onTap: () => context.go('/plays/connect4'),
                    ),
                    _GameCard(
                      title: 'Coming Soon',
                      description: 'More exciting games on the way!',
                      icon: Icons.hourglass_empty,
                      color: Colors.grey,
                      width: itemWidth,
                      height: itemHeight,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('More games coming soon!'),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final double width;
  final double height;

  const _GameCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return SizedBox(
      width: width,
      height: height,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color.withOpacity(0.1),
                  color.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: isMobile ? 40 : 48,
                  color: color,
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
