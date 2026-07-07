import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/quick_config.dart';
import '../../models/landing_page_data_provider.dart';
import '../../models/work_experience_model.dart';
import '../../utils/responsive_utils.dart';
import '../components/landing_design_system.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({
    super.key,
    this.background,
  });

  final Color? background;

  @override
  Widget build(BuildContext context) {
    final workExp = LandingPageDataProvider.workExperience;

    return LandingSection(
      eyebrow: 'Current Work',
      title: '${workExp.jobTitle} at ${workExp.company}',
      body:
          'Production Flutter work across architecture, delivery, quality, and release systems.',
      background: background,
      child: _ExperienceLayout(workExp: workExp),
    );
  }
}

class _ExperienceLayout extends StatelessWidget {
  const _ExperienceLayout({required this.workExp});

  final WorkExperienceModel workExp;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _RoleSummary(workExp: workExp),
          const Gap(28),
          const _ImplementationTimeline(),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: _RoleSummary(workExp: workExp),
        ),
        const Gap(48),
        const Expanded(
          flex: 6,
          child: _ImplementationTimeline(),
        ),
      ],
    );
  }
}

class _RoleSummary extends StatelessWidget {
  const _RoleSummary({required this.workExp});

  final WorkExperienceModel workExp;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(workExp.duration, style: theme.textTheme.labelMedium),
        Gap(tokens.spaceMd),
        Text(workExp.description, style: theme.textTheme.bodyLarge),
        Gap(tokens.spaceLg),
        LandingPanel(
          background: tokens.elevated,
          child: LandingMetricRow(
            items: [
              LandingMetricItem(
                value: QuickConfig.currentMetrics['totalApps']!,
                label: 'apps delivered',
              ),
              LandingMetricItem(
                value: QuickConfig.currentMetrics['averageRating']!,
                label: 'store rating',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ImplementationTimeline extends StatelessWidget {
  const _ImplementationTimeline();

  @override
  Widget build(BuildContext context) {
    const implementations = QuickConfig.experienceImplementations;
    final tokens = context.landingTokens;

    return Column(
      children: [
        for (var index = 0; index < implementations.length; index++) ...[
          _TimelineItem(
            index: index + 1,
            title: implementations[index].title,
            description: implementations[index].description,
            details: implementations[index].details,
          ),
          if (index != implementations.length - 1)
            Divider(height: tokens.spaceXl, color: tokens.border),
        ],
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.index,
    required this.title,
    required this.description,
    required this.details,
  });

  final int index;
  final String title;
  final String description;
  final List<String> details;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isMobile ? 34 : 42,
          child: Text(
            index.toString().padLeft(2, '0'),
            style: theme.textTheme.labelMedium?.copyWith(
              color: tokens.accent,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme.textTheme.titleLarge),
              Gap(tokens.spaceSm),
              Text(description, style: theme.textTheme.bodyMedium),
              Gap(tokens.spaceMd),
              LandingList(items: details, maxItems: 3),
            ],
          ),
        ),
      ],
    );
  }
}
