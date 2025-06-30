import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';
import '../../models/landing_page_data_provider.dart';
import '../../models/technical_skills_model.dart';
import '../../utils/landing_page_utils.dart';

class TechnicalSkillsSection extends StatelessWidget {
  const TechnicalSkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxWidth = ResponsiveUtils.getMaxContentWidth(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: ResponsiveUtils.getVerticalPadding(context),
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context, theme),
              const Gap(32),
              _buildFeaturedTechnologies(context, theme),
              const Gap(40),
              _buildSkillCategories(context, theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, ThemeData theme) {
    final isMobile = ResponsiveUtils.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon with gradient background
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary,
                theme.colorScheme.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Icon(
            Icons.developer_mode_rounded,
            color: Colors.white,
            size: isMobile ? 32 : 40,
          ),
        ),
        const Gap(20),

        // Title
        Text(
          'Technical Skills & Expertise',
          style: isMobile
              ? theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                )
              : theme.textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
          textAlign: TextAlign.center,
        ),
        const Gap(12),

        // Subtitle
        Container(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : 600,
          ),
          child: Text(
            '4+ years of experience building production-ready mobile and web applications with modern technologies',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedTechnologies(BuildContext context, ThemeData theme) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final featuredTech = LandingPageDataProvider.featuredTechnologies;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.star_rounded,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const Gap(12),
            Text(
              'Featured Technologies',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const Gap(16),

        // Featured tech grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _getCrossAxisCount(context),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isMobile ? 1.1 : 1.2,
          ),
          itemCount: featuredTech.length,
          itemBuilder: (context, index) {
            return _buildFeaturedTechCard(featuredTech[index], theme, context);
          },
        ),
      ],
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) return 2;
    if (ResponsiveUtils.isTablet(context)) return 3;
    return 4;
  }

  Widget _buildFeaturedTechCard(
      TechnicalSkillModel tech, ThemeData theme, BuildContext context) {
    final color = LandingPageUtils.getColor(tech.colorName);
    final icon = LandingPageUtils.getIcon(tech.iconName);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon container
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    color.withOpacity(0.8),
                    color,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: isMobile ? 24 : 28,
              ),
            ),
            const Gap(12),

            // Tech name
            Text(
              tech.name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(6),

            // Experience badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: color.withOpacity(0.3),
                ),
              ),
              child: Text(
                '${tech.yearsExperience} years',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // Proficiency level
            const Gap(4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final isActive = index < _getProficiencyLevel(tech.proficiency);
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1),
                  width: 8,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isActive ? color : color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  int _getProficiencyLevel(ProficiencyLevel level) {
    switch (level) {
      case ProficiencyLevel.beginner:
        return 1;
      case ProficiencyLevel.intermediate:
        return 2;
      case ProficiencyLevel.advanced:
        return 3;
      case ProficiencyLevel.expert:
        return 4;
    }
  }

  Widget _buildSkillCategories(BuildContext context, ThemeData theme) {
    final skillCategories = LandingPageDataProvider.technicalSkills;
    final isMobile = ResponsiveUtils.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.grid_view_rounded,
                color: theme.colorScheme.secondary,
                size: 20,
              ),
            ),
            const Gap(12),
            Text(
              'All Skills & Categories',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        const Gap(16),

        // Skill categories
        if (isMobile)
          _buildMobileSkillCategories(skillCategories, theme)
        else
          _buildDesktopSkillCategories(skillCategories, theme, context),
      ],
    );
  }

  Widget _buildMobileSkillCategories(
      List<SkillCategoryModel> categories, ThemeData theme) {
    return Column(
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: _buildSkillCategoryCard(category, theme, isMobile: true),
        );
      }).toList(),
    );
  }

  Widget _buildDesktopSkillCategories(List<SkillCategoryModel> categories,
      ThemeData theme, BuildContext context) {
    final isTablet = ResponsiveUtils.isTablet(context);
    final crossAxisCount = isTablet ? 1 : 2;

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: isTablet ? 4 : 2.2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return _buildSkillCategoryCard(categories[index], theme);
      },
    );
  }

  Widget _buildSkillCategoryCard(SkillCategoryModel category, ThemeData theme,
      {bool isMobile = false}) {
    final color = LandingPageUtils.getColor(category.colorName);
    final icon = LandingPageUtils.getIcon(category.iconName);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      category.title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      category.description,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              // Overall level indicator
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Text(
                  _getLevelText(category.overallLevel),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),

          // Skills list
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: category.skills.map((skill) {
              return _buildSkillChip(skill, theme);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(TechnicalSkillModel skill, ThemeData theme) {
    final color = LandingPageUtils.getColor(skill.colorName);
    final isExpert = skill.proficiency == ProficiencyLevel.expert;
    final isAdvanced = skill.proficiency == ProficiencyLevel.advanced;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isExpert
            ? color.withOpacity(0.15)
            : isAdvanced
                ? color.withOpacity(0.1)
                : color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isExpert ? color.withOpacity(0.4) : color.withOpacity(0.2),
          width: isExpert ? 1.5 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isExpert) ...[
            Icon(
              Icons.star_rounded,
              color: color,
              size: 14,
            ),
            const Gap(4),
          ] else if (isAdvanced) ...[
            Icon(
              Icons.trending_up_rounded,
              color: color,
              size: 14,
            ),
            const Gap(4),
          ],
          Text(
            skill.name,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color,
              fontWeight: isExpert ? FontWeight.bold : FontWeight.w600,
            ),
          ),
          if (skill.yearsExperience > 0) ...[
            const Gap(4),
            Text(
              '${skill.yearsExperience}y',
              style: theme.textTheme.bodySmall?.copyWith(
                color: color.withOpacity(0.8),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getLevelText(ProficiencyLevel level) {
    switch (level) {
      case ProficiencyLevel.beginner:
        return 'Learning';
      case ProficiencyLevel.intermediate:
        return 'Intermediate';
      case ProficiencyLevel.advanced:
        return 'Advanced';
      case ProficiencyLevel.expert:
        return 'Expert';
    }
  }
}
