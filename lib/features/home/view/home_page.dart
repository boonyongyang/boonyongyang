import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/gif_carousel_widget.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../../../shared/widgets/random_quote_widget.dart';
import '../../../shared/widgets/animated_hero_section.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../core/theme/color_palette.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: ColorPalette.darkBackground,
      appBar: const TopNavBar(title: 'Explore'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section with DateTimer
            SizedBox(
              height: isPortrait
                  ? screenSize.height * 0.8
                  : screenSize.height * 0.9,
              child: const AnimatedHeroSection(
                badge: "Flutter Web Showcase",
                title1: "Experience",
                title2: "Interactive Design",
                description:
                    "Discover a world of games, maps, and data visualization in this interactive Flutter web experience.",
              ),
            ),

            // Features Grid with staggered animations
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Gap(48),
                  _buildFeaturesGrid(context),
                  const Gap(48),
                ],
              ),
            ),

            // Carousel Section with glass effect
            Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    theme.scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: isPortrait
                        ? screenSize.width * 0.6
                        : screenSize.height * 0.4,
                    child: const GifCarousel(),
                  ),
                  const Gap(48),
                ],
              ),
            ),

            // Quote Section with enhanced glass effect
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  GlassCard(
                    accentColor: theme.primaryColor,
                    child: const RandomQuoteWidget(),
                  ),
                  const Gap(48),
                ],
              ),
            ),

            // // Date and Time Widget
            // const Positioned(
            //   top: 24,
            //   left: 0,
            //   right: 0,
            //   child: DateTimerWidget(),
            // ),

            // About Section with glass effect
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildAboutSection(context, isPortrait),
                  const Gap(48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final features = [
      (
        title: 'Games & Fun',
        description: 'Challenge yourself with interactive games',
        icon: Icons.games,
        color: Colors.purple,
        path: '/plays'
      ),
      (
        title: 'Data Visualization',
        description: 'Beautiful charts and graphs for data analysis',
        icon: Icons.show_chart,
        color: Colors.green,
        path: '/charts'
      ),
      (
        title: 'Interactive Maps',
        description: 'Explore locations with our interactive mapping system',
        icon: Icons.map,
        color: Colors.blue,
        path: '/maps'
      ),
      (
        title: 'Experimental Lab',
        description: 'Try out our latest experimental features',
        icon: Icons.science,
        color: Colors.orange,
        path: '/labs'
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                'Explore Features',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(24),
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                for (var i = 0; i < features.length; i++)
                  GlassCard(
                    delay: Duration(milliseconds: 200 * i),
                    accentColor: features[i].color,
                    onTap: () => context.go(features[i].path),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          features[i].icon,
                          size: 48,
                          color: features[i].color,
                        ),
                        const Gap(16),
                        Text(
                          features[i].title,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.textPrimary,
                                  ),
                        ),
                        const Gap(8),
                        SizedBox(
                          width: 280,
                          child: Text(
                            features[i].description,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorPalette.textSecondary,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context, bool isPortrait) {
    return Center(
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                ColorPalette.titleGradient.createShader(bounds),
            child: Text(
              'About the Project',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(16),
          GlassCard(
            padding: const EdgeInsets.all(32),
            child: SizedBox(
              width: isPortrait ? double.infinity : 600,
              child: Column(
                children: [
                  Text(
                    'A showcase of interactive Flutter web capabilities',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorPalette.textPrimary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  Text(
                    'This project demonstrates the power of Flutter for web applications, featuring interactive maps, data visualization, experimental features, and engaging games. Explore different sections to experience the full capabilities of modern web development with Flutter.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorPalette.textSecondary,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(24),
                  _buildGlowButton(
                    context: context,
                    onPressed: () => context.go('/about'),
                    icon: Icons.info_outline,
                    label: 'Learn More',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlowButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
  }) {
    return Container(
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
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
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
      ),
    );
  }
}
