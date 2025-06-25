import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';
import '../components/experience_card.dart';

class WorkExperienceSection extends StatelessWidget {
  const WorkExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: ResponsiveUtils.getVerticalPadding(context),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Work Experience',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(48),
          const ExperienceCard(),
        ],
      ),
    );
  }
}
