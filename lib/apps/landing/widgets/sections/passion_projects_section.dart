import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';
import '../../models/project_model.dart';
import '../components/project_card.dart';

class PassionProjectsSection extends StatelessWidget {
  const PassionProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: ResponsiveUtils.getVerticalPadding(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Personal Projects',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth < 600 ? 28 : 36,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(12),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: screenWidth < 600 ? screenWidth * 0.9 : 600,
                  ),
                  child: Text(
                    'Open-source projects and personal experiments that showcase my passion for development',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[600],
                      fontSize: screenWidth < 600 ? 16 : 18,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenWidth < 600 ? 32 : 48),
          // Project cards
          _buildProjectCards(context),
        ],
      ),
    );
  }

  Widget _buildProjectCards(BuildContext context) {
    final projects = ProjectModel.getPersonalProjects();

    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;

        // Determine the number of columns based on available width
        int crossAxisCount;
        double spacing;

        if (availableWidth < 600) {
          // Mobile: Single column
          crossAxisCount = 1;
          spacing = 0;
        } else if (availableWidth < 900) {
          // Small tablets: 2 columns
          crossAxisCount = 2;
          spacing = 20;
        } else if (availableWidth < 1200) {
          // Large tablets/small desktop: 2 columns
          crossAxisCount = 2;
          spacing = 32;
        } else {
          // Large desktop: 3 columns
          crossAxisCount = 3;
          spacing = 32;
        }

        if (crossAxisCount == 1) {
          // For mobile, use Column for better control
          return Column(
            children: projects
                .map((project) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: ProjectCard(project: project),
                    ))
                .toList(),
          );
        } else {
          // For multiple columns, use Wrap for flexible layout
          final cardWidth =
              (availableWidth - (spacing * (crossAxisCount - 1))) /
                  crossAxisCount;

          return Wrap(
            spacing: spacing,
            runSpacing: 24,
            children: projects.map((project) {
              return SizedBox(
                width: cardWidth,
                child: ProjectCard(project: project),
              );
            }).toList(),
          );
        }
      },
    );
  }
}
