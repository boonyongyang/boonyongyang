import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Brand
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.code,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const Gap(12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Boon Yong Yang',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (!isMobile)
                    Text(
                      'Flutter Expert',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Navigation/Actions
          Row(
            children: [
              if (!isMobile) ...[
                TextButton(
                  onPressed: () => UrlLauncherService.launchEmail(),
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Gap(16),
              ],
              IconButton(
                onPressed: UrlLauncherService.launchGitHub,
                icon: const Icon(Icons.code),
                tooltip: 'GitHub',
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
              const Gap(8),
              IconButton(
                onPressed: UrlLauncherService.launchLinkedIn,
                icon: const Icon(Icons.business),
                tooltip: 'LinkedIn',
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
