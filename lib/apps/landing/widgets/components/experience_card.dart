import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/responsive_utils.dart';
import '../../models/landing_page_data_provider.dart';
import '../../utils/landing_page_utils.dart';
import 'technical_skill_section.dart';

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final workExp = LandingPageDataProvider.workExperience;

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
                    LandingPageUtils.getIcon(workExp.companyIconName),
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
                        workExp.jobTitle,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        '${workExp.company} • ${workExp.duration}',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        workExp.description,
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
              _buildResponsiveGrid(context),

            const Gap(32),

            // Technologies timeline
            const TechnicalSkillSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveGrid(BuildContext context) {
    final isTablet = ResponsiveUtils.isTablet(context);
    final cards = _buildImplementationCards(context);

    if (isTablet) {
      // Tablet: 2 columns
      return Column(
        children: [
          for (int i = 0; i < cards.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[i]),
                  const Gap(16),
                  Expanded(
                    child:
                        i + 1 < cards.length ? cards[i + 1] : const SizedBox(),
                  ),
                ],
              ),
            ),
        ],
      );
    } else {
      // Desktop: 2 columns with better spacing
      return Column(
        children: [
          for (int i = 0; i < cards.length; i += 2)
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: cards[i]),
                  const Gap(24),
                  Expanded(
                    child:
                        i + 1 < cards.length ? cards[i + 1] : const SizedBox(),
                  ),
                ],
              ),
            ),
        ],
      );
    }
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
          'Successfully launched both apps on store_links',
          'Laid the groundwork for the core technical architecture still in use today',
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
          'Assisted in building robust CI/CD pipelines using Fastlane and Codemagic',
          'Experimented with Shorebird for OTA updates without app store releases',
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
          'Built custom animations with Rive & Lottie & localization',
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
      return Card(
        elevation: 2,
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtils.isMobile(context) ? 16 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
                if (detail == 'store_links') {
                  return _buildStoreLinks(context);
                }
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
      );
    }).toList();
  }

  // Method to launch URLs
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // Method to build store links widget
  Widget _buildStoreLinks(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Successfully launched apps on:',
          style: theme.textTheme.bodySmall,
        ),
        const Gap(8),

        // Involve Asia App
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📱 Involve Asia App',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(6),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _launchUrl(
                          'https://apps.apple.com/my/app/involve-asia/id6469589952'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.apple, color: Colors.white, size: 16),
                            const Gap(4),
                            Text(
                              'App Store',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: InkWell(
                      onTap: () => _launchUrl(
                          'https://play.google.com/store/apps/details?id=asia.involve.app&hl=en'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.android, color: Colors.white, size: 16),
                            const Gap(4),
                            Text(
                              'Play Store',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Cha Ching App
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '💰 Cha Ching - Shop & Get Cashback',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(6),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => _launchUrl(
                          'https://apps.apple.com/us/app/cha-ching-shop-get-cashback/id6745090543'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.apple, color: Colors.white, size: 16),
                            const Gap(4),
                            Text(
                              'App Store',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Expanded(
                    child: InkWell(
                      onTap: () => _launchUrl(
                          'https://play.google.com/store/apps/details?id=com.cmv.chaching&hl=en'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.green[700],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.android, color: Colors.white, size: 16),
                            const Gap(4),
                            Text(
                              'Play Store',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
