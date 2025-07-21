import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/project_model.dart';
import '../../utils/responsive_utils.dart';

class ProductionAppCard extends StatelessWidget {
  final ProjectModel project;
  final bool isReversed;

  const ProductionAppCard({
    super.key,
    required this.project,
    this.isReversed = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColorFromName(project.colorName);
    final icon = _getIconFromName(project.iconName);
    final isMobile = ResponsiveUtils.isMobile(context);

    if (isMobile) {
      return _buildMobileLayout(context, theme, color, icon);
    } else {
      return _buildDesktopLayout(context, theme, color, icon);
    }
  }

  Widget _buildMobileLayout(
      BuildContext context, ThemeData theme, Color color, IconData icon) {
    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.08),
              color.withOpacity(0.03),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Use unified header for consistency
            _buildHeader(context, theme, color, icon),
            const Gap(24),
            // App mockup - below title
            _buildAppMockup(theme, color, icon),
            const Gap(24),
            _buildAppInfo(theme, color),
            const Gap(24),
            _buildFeatures(theme, color),
            const Gap(24),
            _buildMetricsAndActions(theme, color),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, ThemeData theme, Color color, IconData icon) {
    final content = Row(
      children: [
        // App mockup placeholder
        Expanded(
          flex: 2,
          child: _buildAppMockup(theme, color, icon),
        ),
        const Gap(32),
        // App details
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, theme, color, icon),
              const Gap(20),
              _buildAppInfo(theme, color),
              const Gap(20),
              _buildFeatures(theme, color),
              const Gap(20),
              _buildMetricsAndActions(theme, color),
            ],
          ),
        ),
      ],
    );

    return Card(
      elevation: 8,
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color.withOpacity(0.08),
              color.withOpacity(0.03),
            ],
          ),
        ),
        child: isReversed
            ? Row(
                children: [
                  // App details
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildHeader(context, theme, color, icon),
                        const Gap(20),
                        _buildAppInfo(theme, color),
                        const Gap(20),
                        _buildFeatures(theme, color),
                        const Gap(20),
                        _buildMetricsAndActions(theme, color),
                      ],
                    ),
                  ),
                  const Gap(32),
                  // App mockup placeholder
                  Expanded(
                    flex: 2,
                    child: _buildAppMockup(theme, color, icon),
                  ),
                ],
              )
            : content,
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context, ThemeData theme, Color color, IconData icon) {
    final isMobile = ResponsiveUtils.isMobile(context);

    // Unified responsive layout that always gives title full width
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon and store badges row - with proper constraints
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isMobile ? 28 : 32, // Responsive icon size
              ),
            ),
            const Spacer(),
            // Store badges with intrinsic dimensions
            IntrinsicWidth(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildClickableStoreBadge(
                      'App Store', Icons.apple, theme, true),
                  Gap(isMobile ? 6 : 8), // Responsive spacing
                  _buildClickableStoreBadge(
                      'Google Play', Icons.android, theme, false),
                ],
              ),
            ),
          ],
        ),
        const Gap(16),
        // Title and subtitle - always full width
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: isMobile ? 24 : null, // Responsive font size
              ),
            ),
            Gap(isMobile ? 6 : 4), // Responsive spacing
            Text(
              project.subtitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
                fontSize: isMobile ? 16 : null, // Responsive font size
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildClickableStoreBadge(
      String store, IconData icon, ThemeData theme, bool isAppStore) {
    final storeUrls = _getStoreUrls();
    final url = isAppStore ? storeUrls['appStore']! : storeUrls['playStore']!;

    return InkWell(
      onTap: url.isNotEmpty ? () => _launchUrl(url) : null,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: url.isEmpty ? Border.all(color: Colors.grey) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 16),
            const Gap(4),
            Text(
              store,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreBadge(String store, IconData icon, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const Gap(4),
          Text(
            store,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppMockup(ThemeData theme, Color color, IconData icon) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.1),
          ],
        ),
        border: Border.all(color: color.withOpacity(0.3), width: 2),
      ),
      child: Stack(
        children: [
          // Phone frame mockup
          Center(
            child: Container(
              width: 200,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: Column(
                  children: [
                    // Status bar
                    Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(17),
                          topRight: Radius.circular(17),
                        ),
                      ),
                    ),
                    // App content
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Icon(icon, color: color, size: 48),
                            const Gap(12),
                            Text(
                              project.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(16),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: color.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
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
          ),
          // "Live in Production" badge
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(6),
                  const Text(
                    'LIVE',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfo(ThemeData theme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.description,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.8),
            height: 1.6,
          ),
        ),
        const Gap(16),
        // Key achievements
        Text(
          'Key Achievements',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const Gap(8),
        ...project.achievements.take(3).map((achievement) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.star, size: 16, color: color),
                const Gap(8),
                Expanded(
                  child: Text(
                    achievement,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.9),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildFeatures(ThemeData theme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Core Features',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const Gap(12),
        // Constrained GridView with proper error handling
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = ResponsiveUtils.isMobile(context);
            final isTablet = ResponsiveUtils.isTablet(context);

            // Better responsive grid columns
            int crossAxisCount;
            double childAspectRatio;
            int maxLines;

            if (isMobile) {
              crossAxisCount = 1;
              childAspectRatio = 8;
              maxLines = 2;
            } else if (isTablet) {
              crossAxisCount =
                  1; // Single column for tablet for better readability
              childAspectRatio = 10;
              maxLines = 1;
            } else {
              crossAxisCount = 2; // Desktop can handle 2 columns
              childAspectRatio = 5;
              maxLines = 1;
            }

            final itemCount =
                project.features.length > 6 ? 6 : project.features.length;

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                if (index >= project.features.length) {
                  return const SizedBox.shrink();
                }

                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 10 : 8,
                    vertical: isMobile ? 6 : 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: color.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check, size: 14, color: color),
                      const Gap(4),
                      Expanded(
                        child: Text(
                          project.features[index],
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: color,
                            fontWeight: FontWeight.w500,
                            fontSize: isMobile ? 12 : 11,
                          ),
                          maxLines: maxLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        const Gap(12),
        // Technology stack
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: project.technologies.map((tech) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Text(
                tech,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildMetricsAndActions(ThemeData theme, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Metrics
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.analytics, color: color, size: 24),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Performance',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      project.metrics,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        // Actions
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _launchUrl(_getStoreUrls()['appStore']!);
                },
                icon: const Icon(Icons.apple, size: 18),
                label: const Text('App Store'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  _launchUrl(_getStoreUrls()['playStore']!);
                },
                icon: const Icon(Icons.android, size: 18),
                label: const Text('Google Play'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Method to launch URLs
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // Method to get store URLs based on project title
  Map<String, String> _getStoreUrls() {
    if (project.title.toLowerCase().contains('involve')) {
      return {
        'appStore': 'https://apps.apple.com/my/app/involve-asia/id6469589952',
        'playStore':
            'https://play.google.com/store/apps/details?id=asia.involve.app&hl=en',
      };
    } else if (project.title.toLowerCase().contains('cha ching')) {
      return {
        'appStore':
            'https://apps.apple.com/us/app/cha-ching-shop-get-cashback/id6745090543',
        'playStore':
            'https://play.google.com/store/apps/details?id=com.cmv.chaching&hl=en',
      };
    }
    return {'appStore': '', 'playStore': ''};
  }

  Color _getColorFromName(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'orange':
        return Colors.orange;
      case 'green':
        return Colors.green;
      case 'purple':
        return Colors.purple;
      case 'red':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName.toLowerCase()) {
      case 'trending_up':
        return Icons.trending_up;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'account_balance_wallet':
        return Icons.account_balance_wallet;
      case 'architecture':
        return Icons.architecture;
      case 'phone_android':
        return Icons.phone_android;
      default:
        return Icons.apps;
    }
  }
}
