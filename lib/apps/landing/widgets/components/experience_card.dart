import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';
import 'tech_timeline.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with company info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.phone_android,
                    size: 30,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Engineer (Flutter)',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'IA • May 2023 – Present (2 years and counting)',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        'Led end-to-end mobile development for two production applications from architecture to App Store deployment. '
                        'Owned complete technical architecture, implemented robust CI/CD pipelines, and delivered scalable Flutter solutions.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Gap(32),

            // Technical implementations
            Text(
              'Key Technical Implementations',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(16),

            if (isMobile)
              Column(
                children: _buildImplementationCards(context),
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _buildImplementationCards(context),
              ),

            const Gap(32),

            // Technologies timeline
            const TechTimeline(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImplementationCards(BuildContext context) {
    final implementations = [
      {
        'title': 'Mobile App Architecture & Delivery',
        'icon': Icons.architecture,
        'description':
            'Architected and delivered two production Flutter applications from concept to App Store deployment using strategic architectural patterns.',
        'details': [
          'Applied BLoC Feature First for rapid 3.5-month launch cycle',
          'Implemented Clean Architecture for scalable, maintainable codebases',
          'Successfully launched both apps on Apple App Store & Google Play Store',
          'Owned complete top-down technical architecture decisions',
        ],
        'tech': [
          'Flutter',
          'BLoC/Cubit',
          'Clean Architecture',
          'App Store',
          'Google Play'
        ],
      },
      {
        'title': 'Core Development Infrastructure',
        'icon': Icons.settings_system_daydream,
        'description':
            'Built robust foundational systems including state management, networking, navigation, and local data persistence with performance optimization.',
        'details': [
          'Implemented BLoC/Cubit state management with Repository pattern',
          'Built network layer with Dio, Retrofit, Freezed for API consistency',
          'Managed complex navigation with GoRouter and deep linking',
          'Utilized Hive for high-performance local data caching',
        ],
        'tech': [
          'BLoC',
          'Repository Pattern',
          'Get_it DI',
          'GoRouter',
          'Hive',
          'Dio'
        ],
      },
      {
        'title': 'CI/CD & Quality Assurance Pipeline',
        'icon': Icons.sync,
        'description':
            'Engineered comprehensive development workflows with automated testing, deployment pipelines, and monitoring systems.',
        'details': [
          'Built robust CI/CD pipelines using Fastlane and Codemagic',
          'Integrated Shorebird for OTA updates without app store releases',
          'Implemented comprehensive unit, widget, and integration testing (Patrol)',
          'Optimized performance using Dart DevTools profiling',
        ],
        'tech': [
          'Fastlane',
          'Codemagic',
          'Shorebird',
          'Patrol Testing',
          'Dart DevTools'
        ],
      },
      {
        'title': 'Advanced Features & Backend Integration',
        'icon': Icons.integration_instructions,
        'description':
            'Developed complex UI/UX features, third-party integrations, and collaborated on full-stack optimizations including recent S3 and notification systems.',
        'details': [
          'Built custom animations with Rive & Lottie, offline sync & localization',
          'Integrated Firebase suite, UXCam analytics, and Singular attribution',
          'Optimized API queries for faster response times (recent)',
          'Implemented S3 image storage and Vue.js 3 admin panel features (recent)',
        ],
        'tech': [
          'Firebase',
          'Rive',
          'Lottie',
          'UXCam',
          'AWS S3',
          'Vue.js 3',
          'Laravel'
        ],
      },
    ];

    return implementations.map((impl) {
      return SizedBox(
        width: ResponsiveUtils.isMobile(context) ? double.infinity : 300,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      impl['icon'] as IconData,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const Gap(8),
                    Expanded(
                      child: Text(
                        impl['title'] as String,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                const Gap(12),
                Text(
                  impl['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                ),
                const Gap(16),

                // Implementation details
                ...((impl['details'] as List<String>).map((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const Gap(8),
                        Expanded(
                          child: Text(
                            detail,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),

                const Gap(16),

                // Technologies
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: (impl['tech'] as List<String>).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tech,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }
}
