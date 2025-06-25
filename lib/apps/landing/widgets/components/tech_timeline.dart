import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';

class TechTimeline extends StatelessWidget {
  const TechTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);
    final isTablet = ResponsiveUtils.isTablet(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technical Skills & Tools',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(8),
        Text(
          'Technologies and tools I\'ve mastered and used in production',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
          ),
        ),
        const Gap(32),

        // Skills Grid - Fixed for mobile
        if (isMobile)
          Column(
            children: _getSkillCategories().map((category) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildSkillCard(category, theme),
              );
            }).toList(),
          )
        else
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isTablet ? 3 : 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isTablet ? 1.1 : 1.2,
            children: _getSkillCategories().map((category) {
              return _buildSkillCard(category, theme);
            }).toList(),
          ),

        const Gap(24),

        // Featured Technologies - Compact Overview
        _buildFeaturedTechnologies(theme),
      ],
    );
  }

  List<SkillCategory> _getSkillCategories() {
    return [
      SkillCategory(
        title: 'Mobile Dev',
        icon: Icons.phone_android,
        color: const Color(0xFF1976D2),
        skills: ['Flutter', 'Dart', 'iOS', 'Android', 'BLoC', 'Firebase'],
        level: 'Expert',
      ),
      SkillCategory(
        title: 'Frontend',
        icon: Icons.web,
        color: const Color(0xFF2196F3),
        skills: ['Vue.js', 'React', 'TypeScript', 'JavaScript', 'HTML5'],
        level: 'Advanced',
      ),
      SkillCategory(
        title: 'Backend',
        icon: Icons.storage,
        color: const Color(0xFF673AB7),
        skills: ['Laravel', 'Node.js', 'MySQL', 'MongoDB', 'AWS'],
        level: 'Advanced',
      ),
      SkillCategory(
        title: 'Cloud & DevOps',
        icon: Icons.cloud_queue,
        color: const Color(0xFF4CAF50),
        skills: ['AWS', 'Firebase', 'Docker', 'CI/CD', 'GitHub Actions'],
        level: 'Intermediate',
      ),
      SkillCategory(
        title: 'Analytics & Tools',
        icon: Icons.analytics,
        color: const Color(0xFFFF9800),
        skills: ['Figma', 'UXCam', 'Singular', 'Sentry', 'Analytics'],
        level: 'Advanced',
      ),
      SkillCategory(
        title: 'Project Mgmt',
        icon: Icons.assignment,
        color: const Color(0xFF795548),
        skills: ['ClickUp', 'Basecamp', 'GitHub', 'Slack', 'Discord'],
        level: 'Advanced',
      ),
    ];
  }

  Widget _buildSkillCard(SkillCategory category, ThemeData theme) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = ResponsiveUtils.isMobile(context);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category.color.withOpacity(0.05),
                category.color.withOpacity(0.1),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: category.color.withOpacity(0.2)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with icon and level
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: category.color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        category.icon,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const Gap(
                        8), // Fixed spacing instead of Spacer to prevent overflow
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            category.level,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: category.color,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const Gap(12),

                // Title
                Text(
                  category.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const Gap(8),

                // Skills as compact chips - Fixed for mobile
                if (isMobile)
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: category.skills.take(6).map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: category.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 10,
                            color: category.color.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                else
                  Expanded(
                    child: Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: category.skills.take(6).map((skill) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: category.color.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 10,
                              color: category.color.withOpacity(0.9),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFeaturedTechnologies(ThemeData theme) {
    final technologies = [
      TechItem('Flutter', Icons.phone_android, const Color(0xFF02569B)),
      TechItem('Vue.js', Icons.web, const Color(0xFF4FC08D)),
      TechItem('Laravel', Icons.code, const Color(0xFFFF2D20)),
      TechItem('AWS', Icons.cloud, const Color(0xFFFF9900)),
      TechItem('Firebase', Icons.whatshot, const Color(0xFFFFCA28)),
      TechItem('TypeScript', Icons.data_object, const Color(0xFF3178C6)),
      TechItem('MySQL', Icons.storage, const Color(0xFF4479A1)),
      TechItem('Figma', Icons.design_services, const Color(0xFFF24E1E)),
      TechItem('ClickUp', Icons.task, const Color(0xFF7B68EE)),
      TechItem('Sentry', Icons.bug_report, const Color(0xFF362D59)),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Technologies',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const Gap(16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16),
            border:
                Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
          ),
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: technologies.map((tech) {
              return _buildTechItem(tech);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildTechItem(TechItem tech) {
    return Builder(
      builder: (context) {
        final theme = Theme.of(context);
        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withOpacity(0.8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: tech.color.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: tech.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  tech.icon,
                  color: tech.color,
                  size: 24,
                ),
              ),
              const Gap(8),
              Text(
                tech.name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      },
    );
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

class TechItem {
  final String name;
  final IconData icon;
  final Color color;

  TechItem(this.name, this.icon, this.color);
}
