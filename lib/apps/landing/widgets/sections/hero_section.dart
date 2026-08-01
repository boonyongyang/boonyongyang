import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/quick_config.dart';
import '../../models/landing_page_data_provider.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';
import '../components/landing_design_system.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final personalInfo = LandingPageDataProvider.personalInfo;

    return DecoratedBox(
      decoration: BoxDecoration(color: tokens.background),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          ResponsiveUtils.getHorizontalPadding(context),
          isMobile ? 56 : 88,
          ResponsiveUtils.getHorizontalPadding(context),
          isMobile ? 64 : 96,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: tokens.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LandingBadge(
                  label: personalInfo.subtitle,
                  emphasis: true,
                ),
                Gap(isMobile ? 22 : 30),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 920),
                  child: Text(
                    personalInfo.name,
                    style: isMobile
                        ? theme.textTheme.displayMedium?.copyWith(fontSize: 46)
                        : theme.textTheme.displayLarge,
                  ),
                ),
                Gap(tokens.spaceMd),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: Text(
                    personalInfo.title,
                    style: isMobile
                        ? theme.textTheme.headlineSmall
                        : theme.textTheme.headlineMedium,
                  ),
                ),
                Gap(tokens.spaceLg),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 720),
                  child: Text(
                    personalInfo.description,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
                Gap(isMobile ? 28 : 36),
                const Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    LandingButton(
                      label: 'Email me',
                      icon: Icons.mail_outline,
                      primary: true,
                      onPressed: UrlLauncherService.launchEmail,
                    ),
                    LandingButton(
                      label: 'View GitHub',
                      icon: Icons.code,
                      onPressed: UrlLauncherService.launchGitHub,
                    ),
                    LandingButton(
                      label: 'LinkedIn',
                      icon: Icons.business_center_outlined,
                      onPressed: UrlLauncherService.launchLinkedIn,
                    ),
                  ],
                ),
                Gap(isMobile ? 40 : 56),
                DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: tokens.border),
                      bottom: BorderSide(color: tokens.border),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: isMobile ? 18 : 22,
                    ),
                    child: LandingMetricRow(
                      items: [
                        LandingMetricItem(
                          value: QuickConfig.currentMetrics['productionApps']!,
                          label: 'production apps shipped',
                        ),
                        LandingMetricItem(
                          value: QuickConfig.currentMetrics['storeCoverage']!,
                          label: 'store coverage',
                        ),
                        LandingMetricItem(
                          value: QuickConfig.currentMetrics['yearsExperience']!,
                          label: 'years building Flutter apps',
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
    );
  }
}
