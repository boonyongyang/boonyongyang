import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';
import '../../models/landing_page_data_provider.dart';
import '../../models/social_link_model.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final footerInfo = LandingPageDataProvider.footerInfo;

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
                _buildContactInfo(theme, footerInfo),
                _buildSocialLinks(theme),
              ],
            )
          else
            Column(
              children: [
                _buildContactInfo(theme, footerInfo),
                const Gap(24),
                _buildSocialLinks(theme),
              ],
            ),
          const Gap(24),
          Divider(color: theme.colorScheme.outline.withOpacity(0.2)),
          const Gap(16),
          Text(
            footerInfo.copyrightText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildContactInfo(ThemeData theme, FooterInfoModel footerInfo) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          footerInfo.contactTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          footerInfo.contactSubtitle,
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
    final socialLinks = LandingPageDataProvider.socialLinks;

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
          children: socialLinks
              .map((link) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () => _launchSocialUrl(link.url),
                      icon: Icon(_getSocialIcon(link.iconName)),
                      tooltip: link.displayText,
                      style: IconButton.styleFrom(
                        backgroundColor:
                            theme.colorScheme.primary.withOpacity(0.1),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  IconData _getSocialIcon(String iconName) {
    switch (iconName) {
      case 'code':
        return Icons.code;
      case 'work':
        return Icons.business;
      case 'email':
        return Icons.email;
      default:
        return Icons.link;
    }
  }

  void _launchSocialUrl(String url) {
    if (url.startsWith('mailto:')) {
      UrlLauncherService.launchEmail();
    } else if (url.contains('github')) {
      UrlLauncherService.launchGitHub();
    } else if (url.contains('linkedin')) {
      UrlLauncherService.launchLinkedIn();
    }
  }
}
