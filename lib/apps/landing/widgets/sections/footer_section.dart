import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: 40,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          if (!isMobile)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildContactInfo(theme),
                _buildSocialLinks(theme),
              ],
            )
          else
            Column(
              children: [
                _buildContactInfo(theme),
                const Gap(24),
                _buildSocialLinks(theme),
              ],
            ),
          const Gap(24),
          Divider(color: theme.colorScheme.outline.withOpacity(0.2)),
          const Gap(16),
          Text(
            '© 2025 Boon Yong Yang. Built with Flutter.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Get in Touch',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          'Available for Flutter development opportunities',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const Gap(16),
        ElevatedButton.icon(
          onPressed: UrlLauncherService.launchEmail,
          icon: const Icon(Icons.email),
          label: const Text('Contact Me'),
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
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
    );
  }
}
