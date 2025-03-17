import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../../../core/style/style.dart';

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
      body: Container(
        decoration: const BoxDecoration(gradient: AppGradients.cyberHorizon),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Available Games',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppColors.hologramWhite,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: AppSpacing.sm),
              Text(
                'Choose a game to play',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.ghostBlue,
                    ),
              ),
              SizedBox(height: AppSpacing.lg),
              LayoutBuilder(
                builder: (context, constraints) {
                  final itemWidth = (constraints.maxWidth -
                          (crossAxisCount - 1) * AppSpacing.md) /
                      crossAxisCount;
                  final itemHeight = itemWidth * 0.8;

                  return Wrap(
                    spacing: AppSpacing.md,
                    runSpacing: AppSpacing.md,
                    children: [
                      _GameCard(
                        title: 'Snake Battle',
                        description: 'Classic snake game with AI opponent',
                        icon: Icons.sports_esports,
                        color: AppColors.successGreen,
                        width: itemWidth,
                        height: itemHeight,
                        onTap: () => context.go('/plays/snake'),
                      ),
                      _GameCard(
                        title: 'Brick Breaker',
                        description: 'Break bricks and collect power-ups',
                        icon: Icons.games,
                        color: AppColors.neonAqua,
                        width: itemWidth,
                        height: itemHeight,
                        onTap: () => context.go('/plays/brick-breaker'),
                      ),
                      _GameCard(
                        title: 'AI Tic Tac Toe',
                        description: 'Challenge our unbeatable AI!',
                        icon: Icons.computer,
                        color: AppColors.laserAmber,
                        width: itemWidth,
                        height: itemHeight,
                        onTap: () => context.go('/plays/tic-tac-toe'),
                      ),
                      _GameCard(
                        title: 'Connect 4',
                        description: 'Classic two-player connection game',
                        icon: Icons.connect_without_contact,
                        color: AppColors.cyberpunkPurple,
                        width: itemWidth,
                        height: itemHeight,
                        onTap: () => context.go('/plays/connect4'),
                      ),
                      _GameCard(
                        title: 'Coming Soon',
                        description: 'More exciting games on the way!',
                        icon: Icons.hourglass_empty,
                        color: AppColors.matrixSilver,
                        width: itemWidth,
                        height: itemHeight,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'More games coming soon!',
                                style:
                                    TextStyle(color: AppColors.hologramWhite),
                              ),
                              backgroundColor: AppColors.techNavy,
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
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.roundedMedium,
          side: BorderSide(
            color: color.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppBorders.roundedMedium,
          child: Container(
            padding: EdgeInsets.all(isMobile ? AppSpacing.md : AppSpacing.lg),
            decoration: BoxDecoration(
              borderRadius: AppBorders.roundedMedium,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.techNavy,
                  AppColors.midnightBlue,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: isMobile ? 40 : 48,
                  color: color,
                ),
                SizedBox(height: AppSpacing.md),
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
                SizedBox(height: AppSpacing.sm),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.ghostBlue,
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
