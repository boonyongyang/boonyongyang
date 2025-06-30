import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';

class TechnicalSkillSection extends StatelessWidget {
  const TechnicalSkillSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header section
        Text(
          'Technical Skills',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        Text(
          'Technologies I work with',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: isMobile ? 14 : 16,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
        Gap(isMobile ? 20 : 24),

        // Skill categories as horizontal scrollable chips
        _buildSkillCategoriesRow(theme, isMobile),

        Gap(isMobile ? 24 : 32),

        // Featured technologies grid
        _buildTechnologiesGrid(theme, isMobile, isTablet),
      ],
    );
  }

  List<SkillCategory> _getSkillCategories() {
    return [
      SkillCategory(
        title: 'Mobile',
        icon: Icons.phone_android,
        color: const Color(0xFF1976D2),
        skills: ['Flutter', 'Dart', 'iOS', 'Android', 'BLoC', 'Firebase Auth'],
        level: 'Expert',
      ),
      SkillCategory(
        title: 'Frontend',
        icon: Icons.web,
        color: const Color(0xFF2196F3),
        skills: ['Vue.js', 'TypeScript', 'HTML5', 'CSS3'],
        level: 'Advanced',
      ),
      SkillCategory(
        title: 'Backend',
        icon: Icons.storage,
        color: const Color(0xFF673AB7),
        skills: ['Laravel', 'Node.js', 'MySQL', 'REST APIs', 'GraphQL'],
        level: 'Advanced',
      ),
      SkillCategory(
        title: 'Cloud',
        icon: Icons.cloud_queue,
        color: const Color(0xFF4CAF50),
        skills: ['AWS', 'Firebase', 'Docker', 'CI/CD', 'GitHub Actions'],
        level: 'Intermediate',
      ),
      SkillCategory(
        title: 'Tools',
        icon: Icons.build,
        color: const Color(0xFFFF9800),
        skills: [
          'Figma',
          'Git',
          'VS Code',
          'Postman',
          'Sentry',
        ],
        level: 'Advanced',
      ),
    ];
  }

  Widget _buildCategorySection(
      SkillCategory category, ThemeData theme, bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 16),
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.02),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: category.color.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Category header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  category.icon,
                  size: 14,
                  color: category.color,
                ),
              ),
              const Gap(8),
              Expanded(
                child: Text(
                  category.title,
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    fontWeight: FontWeight.w600,
                    color: category.color,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: category.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  category.level,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: category.color,
                  ),
                ),
              ),
            ],
          ),
          Gap(isMobile ? 8 : 10),

          // Technologies in this category
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: category.skills.map((skill) {
              return _buildSkillChip(skill, category.color, theme, isMobile);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(
      String skill, Color categoryColor, ThemeData theme, bool isMobile) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 8 : 10,
        vertical: isMobile ? 4 : 6,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: categoryColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        skill,
        style: TextStyle(
          fontSize: isMobile ? 11 : 12,
          fontWeight: FontWeight.w500,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildSkillCategoriesRow(ThemeData theme, bool isMobile) {
    final categories = _getSkillCategories();

    if (isMobile) {
      return Wrap(
        spacing: 8,
        runSpacing: 8,
        children: categories.map((category) {
          return _buildCategoryChip(category, theme);
        }).toList(),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: _buildCategoryChip(category, theme),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryChip(SkillCategory category, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: category.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: category.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            category.icon,
            size: 16,
            color: category.color,
          ),
          const Gap(6),
          Text(
            category.title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: category.color,
            ),
          ),
          const Gap(4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              category.level,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w600,
                color: category.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTechnologiesGrid(ThemeData theme, bool isMobile, bool isTablet) {
    final categories = _getSkillCategories();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technologies by Category',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(isMobile ? 16 : 24),

        // Responsive layout based on screen size
        if (isMobile)
          // Mobile: Vertical stack
          ...categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildCategorySection(category, theme, isMobile),
            );
          }).toList()
        else if (isTablet)
          // Tablet: 2 columns
          _buildTabletGrid(categories, theme)
        else
          // Desktop: 3 columns with compact layout
          _buildDesktopGrid(categories, theme),
      ],
    );
  }

  Widget _buildTabletGrid(List<SkillCategory> categories, ThemeData theme) {
    final rows = <Widget>[];
    for (int i = 0; i < categories.length; i += 2) {
      final rowCategories = categories.skip(i).take(2).toList();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCategorySection(rowCategories[0], theme, false),
              ),
              const Gap(16),
              Expanded(
                child: rowCategories.length > 1
                    ? _buildCategorySection(rowCategories[1], theme, false)
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }

  Widget _buildDesktopGrid(List<SkillCategory> categories, ThemeData theme) {
    final rows = <Widget>[];
    for (int i = 0; i < categories.length; i += 3) {
      final rowCategories = categories.skip(i).take(3).toList();
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildCategorySection(rowCategories[0], theme, false),
              ),
              const Gap(20),
              Expanded(
                child: rowCategories.length > 1
                    ? _buildCategorySection(rowCategories[1], theme, false)
                    : const SizedBox(),
              ),
              const Gap(20),
              Expanded(
                child: rowCategories.length > 2
                    ? _buildCategorySection(rowCategories[2], theme, false)
                    : const SizedBox(),
              ),
            ],
          ),
        ),
      );
    }
    return Column(children: rows);
  }
}

class SkillCategory {
  final String title;
  final IconData icon;
  final Color color;
  final List<String> skills;
  final String level;

  SkillCategory({
    required this.title,
    required this.icon,
    required this.color,
    required this.skills,
    required this.level,
  });
}
