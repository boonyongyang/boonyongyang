import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/gif_carousel_widget.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../../../shared/widgets/random_quote_widget.dart';
import '../../../shared/widgets/date_timer_widget.dart';
import '../../../shared/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      appBar: const TopNavBar(title: 'Explore'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Section with Date Timer
              Center(
                child: Column(
                  children: [
                    const DateTimerWidget(),
                    const Gap(16),
                    Text(
                      'Interactive Experiences',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(8),
                    Text(
                      'Discover a world of games, maps, and data visualization',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(32),
                  ],
                ),
              ),

              // Featured Content Carousel
              SizedBox(
                height: isPortrait
                    ? screenSize.width * 0.6
                    : screenSize.height * 0.4,
                child: const GifCarousel(),
              ),
              const Gap(48),

              // Inspirational Quote Section
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  color: theme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    RandomQuoteWidget(),
                  ],
                ),
              ),
              const Gap(48),

              // Features Grid
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore Features',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(24),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _FeatureCard(
                            title: 'Games & Fun',
                            description:
                                'Challenge yourself with interactive games',
                            icon: Icons.games,
                            color: Colors.purple,
                            onTap: () => context.go('/plays'),
                          ),
                          _FeatureCard(
                            title: 'Data Visualization',
                            description:
                                'Beautiful charts and graphs for data analysis',
                            icon: Icons.show_chart,
                            color: Colors.green,
                            onTap: () => context.go('/charts'),
                          ),
                          _FeatureCard(
                            title: 'Interactive Maps',
                            description:
                                'Explore locations with our interactive mapping system',
                            icon: Icons.map,
                            color: Colors.blue,
                            onTap: () => context.go('/maps'),
                          ),
                          _FeatureCard(
                            title: 'Experimental Lab',
                            description:
                                'Try out our latest experimental features',
                            icon: Icons.science,
                            color: Colors.orange,
                            onTap: () => context.go('/labs'),
                          ),
                        ],
                      ),
                      const Gap(48),

                      // About Section with Custom Button
                      Center(
                        child: Column(
                          children: [
                            Text(
                              'About the Project',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(16),
                            SizedBox(
                              width: isPortrait ? double.infinity : 600,
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        'A showcase of interactive Flutter web capabilities',
                                        style: theme.textTheme.titleLarge,
                                        textAlign: TextAlign.center,
                                      ),
                                      const Gap(16),
                                      Text(
                                        'This project demonstrates the power of Flutter for web applications, featuring interactive maps, data visualization, experimental features, and engaging games. Explore different sections to experience the full capabilities of modern web development with Flutter.',
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: Colors.grey[600],
                                          height: 1.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const Gap(24),
                                      ElevatedButton.icon(
                                        onPressed: () => context.go('/about'),
                                        icon: const Icon(Icons.info_outline),
                                        label: const Text('Learn More'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: theme.primaryColor,
                                          foregroundColor: Colors.white,
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 280,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 48, color: color),
              const Gap(16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Gap(8),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
