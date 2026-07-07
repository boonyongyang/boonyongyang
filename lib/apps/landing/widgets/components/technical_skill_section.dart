import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../config/quick_config.dart';
import '../../utils/responsive_utils.dart';
import 'landing_design_system.dart';

class TechnicalSkillSection extends StatelessWidget {
  const TechnicalSkillSection({super.key});

  @override
  Widget build(BuildContext context) {
    const categories = QuickConfig.skillCategories;
    final isMobile = ResponsiveUtils.isMobile(context);

    if (isMobile) {
      return Column(
        children: [
          for (final category in categories)
            _SkillRow(
              title: category.title,
              level: category.level,
              skills: category.skills,
            ),
        ],
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 920 ? 2 : 1;
        final width =
            (constraints.maxWidth - (columns == 2 ? 28 : 0)) / columns;

        return Wrap(
          spacing: 28,
          runSpacing: 0,
          children: categories.map((category) {
            return SizedBox(
              width: width,
              child: _SkillRow(
                title: category.title,
                level: category.level,
                skills: category.skills,
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _SkillRow extends StatelessWidget {
  const _SkillRow({
    required this.title,
    required this.level,
    required this.skills,
  });

  final String title;
  final String level;
  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: tokens.border)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 22),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: theme.textTheme.titleMedium),
                  Gap(tokens.spaceXs),
                  Text(level, style: theme.textTheme.bodySmall),
                ],
              ),
            ),
            Gap(tokens.spaceLg),
            Expanded(
              flex: 5,
              child: Text(
                skills.join(' / '),
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
