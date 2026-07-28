import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:boonyongyang/shared/widgets/portfolio_version_menu.dart';

import '../../config/quick_config.dart';
import '../../services/url_launcher_service.dart';
import '../../theme/landing_theme.dart';
import '../../utils/responsive_utils.dart';
import '../components/landing_design_system.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({
    super.key,
    required this.activePreset,
    required this.onThemeChanged,
  });

  final LandingThemePreset activePreset;
  final ValueChanged<LandingThemePreset> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: tokens.background.withOpacity(0.96),
        border: Border(bottom: BorderSide(color: tokens.border)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getHorizontalPadding(context),
          vertical: isMobile ? 12 : 16,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: tokens.maxWidth),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        QuickConfig.headerTitle,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: tokens.text,
                        ),
                      ),
                      if (!isMobile)
                        Text(
                          QuickConfig.headerSubtitle,
                          style: theme.textTheme.bodySmall,
                        ),
                    ],
                  ),
                ),
                if (!isMobile) ...[
                  const TextButton(
                    onPressed: UrlLauncherService.launchEmail,
                    child: Text('Contact'),
                  ),
                  const Gap(4),
                  const TextButton(
                    onPressed: UrlLauncherService.launchGitHub,
                    child: Text('GitHub'),
                  ),
                  const Gap(10),
                ],
                PortfolioVersionMenu(
                  currentSurface: PortfolioSurface.flutterPortfolio,
                  compact: isMobile,
                  foregroundColor: tokens.textMuted,
                  borderColor: tokens.border,
                ),
                const Gap(8),
                _ThemeMenu(
                  activePreset: activePreset,
                  onThemeChanged: onThemeChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeMenu extends StatelessWidget {
  const _ThemeMenu({
    required this.activePreset,
    required this.onThemeChanged,
  });

  final LandingThemePreset activePreset;
  final ValueChanged<LandingThemePreset> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return PopupMenuButton<LandingThemePreset>(
      tooltip: 'Theme',
      initialValue: activePreset,
      onSelected: onThemeChanged,
      itemBuilder: (context) {
        return LandingThemePreset.values.map((preset) {
          return PopupMenuItem(
            value: preset,
            child: Row(
              children: [
                if (preset == activePreset)
                  Icon(Icons.check, size: 16, color: tokens.accent)
                else
                  const SizedBox(width: 16),
                const Gap(10),
                Text(preset.label),
              ],
            ),
          );
        }).toList();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tokens.radiusSm),
          border: Border.all(color: tokens.border),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.contrast, size: 16, color: tokens.textMuted),
              const Gap(8),
              Text(
                activePreset.shortLabel,
                style: theme.textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
