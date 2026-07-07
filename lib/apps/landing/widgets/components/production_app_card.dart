import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/quick_config.dart';
import '../../models/project_model.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';
import 'landing_design_system.dart';

class ProductionAppCard extends StatelessWidget {
  const ProductionAppCard({
    super.key,
    required this.project,
    this.isReversed = false,
  });

  final ProjectModel project;
  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return LandingPanel(
      child: isMobile
          ? _MobileCaseStudy(project: project)
          : _DesktopCaseStudy(project: project, isReversed: isReversed),
    );
  }
}

class _DesktopCaseStudy extends StatelessWidget {
  const _DesktopCaseStudy({
    required this.project,
    required this.isReversed,
  });

  final ProjectModel project;
  final bool isReversed;

  @override
  Widget build(BuildContext context) {
    final summary = _CaseStudySummary(project: project);
    final detail = _CaseStudyDetail(project: project);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: isReversed
          ? [
              Expanded(flex: 7, child: detail),
              const Gap(48),
              Expanded(flex: 4, child: summary),
            ]
          : [
              Expanded(flex: 4, child: summary),
              const Gap(48),
              Expanded(flex: 7, child: detail),
            ],
    );
  }
}

class _MobileCaseStudy extends StatelessWidget {
  const _MobileCaseStudy({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CaseStudySummary(project: project),
        const Gap(28),
        _CaseStudyDetail(project: project),
      ],
    );
  }
}

class _CaseStudySummary extends StatelessWidget {
  const _CaseStudySummary({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LandingBadge(label: project.status, emphasis: true),
        Gap(tokens.spaceLg),
        Text(project.title, style: theme.textTheme.headlineMedium),
        Gap(tokens.spaceSm),
        Text(project.subtitle, style: theme.textTheme.bodyMedium),
        Gap(tokens.spaceLg),
        LandingMetricItem(
          value: _metricLead(project.metrics),
          label: _metricTail(project.metrics),
        ),
        Gap(tokens.spaceLg),
        _StoreActions(project: project),
      ],
    );
  }
}

class _CaseStudyDetail extends StatelessWidget {
  const _CaseStudyDetail({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.description, style: theme.textTheme.bodyLarge),
        Gap(tokens.spaceXl),
        _CaseStudyColumns(
          project: project,
        ),
      ],
    );
  }
}

class _CaseStudyColumns extends StatelessWidget {
  const _CaseStudyColumns({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final isMobile = ResponsiveUtils.isMobile(context);

    final outcomes = _CaseStudyBlock(
      title: 'Shipped outcome',
      items: project.achievements,
    );
    final product = _CaseStudyBlock(
      title: 'Product work',
      items: project.features,
      maxItems: 4,
    );

    if (isMobile) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          outcomes,
          Gap(tokens.spaceLg),
          product,
          Gap(tokens.spaceLg),
          _TechLine(technologies: project.technologies),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: outcomes),
        Gap(tokens.spaceXl),
        Expanded(child: product),
        Gap(tokens.spaceXl),
        Expanded(child: _TechLine(technologies: project.technologies)),
      ],
    );
  }
}

class _CaseStudyBlock extends StatelessWidget {
  const _CaseStudyBlock({
    required this.title,
    required this.items,
    this.maxItems = 3,
  });

  final String title;
  final List<String> items;
  final int maxItems;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleSmall),
        Gap(tokens.spaceMd),
        LandingList(items: items, maxItems: maxItems),
      ],
    );
  }
}

class _TechLine extends StatelessWidget {
  const _TechLine({required this.technologies});

  final List<String> technologies;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stack', style: theme.textTheme.titleSmall),
        Gap(tokens.spaceMd),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: technologies.take(5).map((technology) {
            return LandingBadge(label: technology);
          }).toList(),
        ),
      ],
    );
  }
}

class _StoreActions extends StatelessWidget {
  const _StoreActions({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final links = QuickConfig.storeLinksForProject(project.title);
    final hasAppStore = links.appStore.isNotEmpty;
    final hasPlayStore = links.playStore.isNotEmpty;

    if (!hasAppStore && !hasPlayStore) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        if (hasAppStore)
          LandingButton(
            label: 'App Store',
            icon: Icons.apple,
            onPressed: () => UrlLauncherService.launchCustomUrl(links.appStore),
          ),
        if (hasPlayStore)
          LandingButton(
            label: 'Google Play',
            icon: Icons.android,
            onPressed: () =>
                UrlLauncherService.launchCustomUrl(links.playStore),
          ),
      ],
    );
  }
}

String _metricLead(String metrics) {
  final parts = metrics.split(' - ');
  if (parts.length > 1) return parts.first;
  final dotParts = metrics.split(' • ');
  return dotParts.first;
}

String _metricTail(String metrics) {
  final parts = metrics.split(' - ');
  if (parts.length > 1) return parts.skip(1).join(' - ');
  final dotParts = metrics.split(' • ');
  if (dotParts.length > 1) return dotParts.skip(1).join(' • ');
  return 'current product signal';
}
