import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/project_model.dart';
import '../../services/url_launcher_service.dart';
import '../../utils/responsive_utils.dart';
import 'landing_design_system.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
  });

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final isMobile = ResponsiveUtils.isMobile(context);
    final hasGithub =
        project.githubUrl != null && project.githubUrl!.isNotEmpty;

    return InkWell(
      onTap: hasGithub
          ? () => UrlLauncherService.launchCustomUrl(project.githubUrl!)
          : null,
      borderRadius: BorderRadius.circular(tokens.radiusMd),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: tokens.border)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: isMobile ? 22 : 26),
          child: isMobile
              ? _MobileProject(project: project, hasGithub: hasGithub)
              : _DesktopProject(project: project, hasGithub: hasGithub),
        ),
      ),
    );
  }
}

class _DesktopProject extends StatelessWidget {
  const _DesktopProject({
    required this.project,
    required this.hasGithub,
  });

  final ProjectModel project;
  final bool hasGithub;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: _ProjectTitle(project: project, hasGithub: hasGithub),
        ),
        Gap(tokens.spaceXl),
        Expanded(
          flex: 4,
          child: Text(
            project.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        Gap(tokens.spaceXl),
        Expanded(
          flex: 3,
          child: _ProjectMeta(project: project),
        ),
      ],
    );
  }
}

class _MobileProject extends StatelessWidget {
  const _MobileProject({
    required this.project,
    required this.hasGithub,
  });

  final ProjectModel project;
  final bool hasGithub;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProjectTitle(project: project, hasGithub: hasGithub),
        Gap(tokens.spaceMd),
        Text(project.description,
            style: Theme.of(context).textTheme.bodyMedium),
        Gap(tokens.spaceLg),
        _ProjectMeta(project: project),
      ],
    );
  }
}

class _ProjectTitle extends StatelessWidget {
  const _ProjectTitle({
    required this.project,
    required this.hasGithub,
  });

  final ProjectModel project;
  final bool hasGithub;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LandingBadge(label: project.status),
        Gap(tokens.spaceMd),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(project.title, style: theme.textTheme.titleLarge),
            ),
            if (hasGithub) ...[
              Gap(tokens.spaceSm),
              Icon(Icons.north_east, size: 18, color: tokens.accent),
            ],
          ],
        ),
        Gap(tokens.spaceXs),
        Text(project.subtitle, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _ProjectMeta extends StatelessWidget {
  const _ProjectMeta({required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(project.metrics, style: theme.textTheme.labelMedium),
        Gap(tokens.spaceMd),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: project.technologies.take(4).map((technology) {
            return Text(
              technology,
              style: theme.textTheme.bodySmall?.copyWith(
                color: tokens.textMuted,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
