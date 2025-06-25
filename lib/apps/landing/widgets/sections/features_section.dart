import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: ResponsiveUtils.getVerticalPadding(context),
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.surface.withOpacity(0.5),
            theme.colorScheme.primary.withOpacity(0.02),
          ],
        ),
      ),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(theme),
          const Gap(40),

          // Main Features Showcase
          _buildFeaturesShowcase(context, theme),

          const Gap(40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Technical Excellence',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(12),
        Text(
          'Production-ready features and technical capabilities that power scalable applications',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildFeaturesShowcase(BuildContext context, ThemeData theme) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 900;

    final features = [
      _FeatureItem(
        icon: Icons.architecture,
        title: 'Scalable Architecture',
        description: 'Clean Architecture with BLoC patterns',
        color: Colors.blue,
        items: [
          'Feature-first structure',
          'Repository pattern',
          'Dependency injection'
        ],
      ),
      _FeatureItem(
        icon: Icons.speed,
        title: 'Performance',
        description: '60fps smooth experiences',
        color: Colors.green,
        items: [
          'Memory optimization',
          'Widget efficiency',
          'DevTools profiling'
        ],
      ),
      _FeatureItem(
        icon: Icons.security,
        title: 'Quality Assurance',
        description: 'Comprehensive testing & CI/CD',
        color: Colors.orange,
        items: ['Automated testing', 'Patrol integration', 'OTA updates'],
      ),
      _FeatureItem(
        icon: Icons.integration_instructions,
        title: 'Integrations',
        description: 'Modern APIs & services',
        color: Colors.purple,
        items: ['Firebase suite', 'Analytics', 'Push notifications'],
      ),
    ];

    if (isMobile) {
      return Column(
        children: features
            .map((feature) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: _buildCompactFeatureCard(feature, theme),
                ))
            .toList(),
      );
    } else {
      return Row(
        children: features
            .map((feature) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildCompactFeatureCard(feature, theme),
                  ),
                ))
            .toList(),
      );
    }
  }

  Widget _buildCompactFeatureCard(_FeatureItem feature, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: feature.color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: feature.color.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [feature.color, feature.color.withOpacity(0.8)],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(feature.icon, color: Colors.white, size: 32),
          ),
          const Gap(16),

          // Title
          Text(
            feature.title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: feature.color,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),

          // Description
          Text(
            feature.description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(16),

          // Items
          ...feature.items
              .map((item) => Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      children: [
                        Icon(Icons.check_circle,
                            size: 16, color: feature.color),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            item,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _buildTechnicalStats(BuildContext context, ThemeData theme) {
    final stats = [
      _StatItem('2+', 'Years Experience', Icons.timeline),
      _StatItem('2', 'Production Apps', Icons.mobile_friendly),
      _StatItem('10+', 'Technologies', Icons.code),
      _StatItem('99%', 'Uptime', Icons.trending_up),
    ];

    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.1),
            theme.colorScheme.secondary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.2)),
      ),
      child: isMobile
          ? Column(
              children: stats
                  .map((stat) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildStatItem(stat, theme),
                      ))
                  .toList(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  stats.map((stat) => _buildStatItem(stat, theme)).toList(),
            ),
    );
  }

  Widget _buildStatItem(_StatItem stat, ThemeData theme) {
    return Column(
      children: [
        Icon(
          stat.icon,
          size: 32,
          color: theme.colorScheme.primary,
        ),
        const Gap(8),
        Text(
          stat.value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const Gap(4),
        Text(
          stat.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _FeatureItem {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final List<String> items;

  _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.items,
  });
}

class _StatItem {
  final String value;
  final String label;
  final IconData icon;

  _StatItem(this.value, this.label, this.icon);
}
