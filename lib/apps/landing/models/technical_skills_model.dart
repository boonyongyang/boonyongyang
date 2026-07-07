/// Technical Skills model for organized skill management
///
/// - Add new skills to the appropriate category
/// - Update proficiency levels as you grow
/// - Modify the featured technologies list for highlights
class TechnicalSkillModel {
  final String name;
  final String iconName; // Icon identifier
  final String colorName; // Color identifier
  final int yearsExperience; // Years of experience (0-10+)
  final ProficiencyLevel proficiency; // Skill level
  final bool isFeatured; // Show in featured section
  final List<String> projects; // Projects where this skill was used

  const TechnicalSkillModel({
    required this.name,
    required this.iconName,
    required this.colorName,
    required this.yearsExperience,
    required this.proficiency,
    this.isFeatured = false,
    this.projects = const [],
  });
}

enum ProficiencyLevel {
  beginner, // Learning/Basic understanding
  intermediate, // Can work independently
  advanced, // Strong expertise, can lead
  expert, // Deep mastery, can teach others
}

class SkillCategoryModel {
  final String title;
  final String description;
  final String iconName;
  final String colorName;
  final ProficiencyLevel overallLevel;
  final List<TechnicalSkillModel> skills;

  const SkillCategoryModel({
    required this.title,
    required this.description,
    required this.iconName,
    required this.colorName,
    required this.overallLevel,
    required this.skills,
  });

  static List<SkillCategoryModel> getAllSkillCategories() {
    return [
      // Mobile Development (Your Core Expertise)
      const SkillCategoryModel(
        title: 'Mobile Development',
        description: 'Cross-platform & native mobile app development',
        iconName: 'phone_android',
        colorName: 'blue',
        overallLevel: ProficiencyLevel.expert,
        skills: [
          TechnicalSkillModel(
            name: 'Flutter',
            iconName: 'flutter',
            colorName: 'blue',
            yearsExperience: 4,
            proficiency: ProficiencyLevel.expert,
            isFeatured: true,
            projects: ['Involve Asia App', 'Cha Ching', 'PocketFi'],
          ),
          TechnicalSkillModel(
            name: 'Dart',
            iconName: 'dart',
            colorName: 'blue',
            yearsExperience: 4,
            proficiency: ProficiencyLevel.expert,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'iOS Development',
            iconName: 'apple',
            colorName: 'grey',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'Android Development',
            iconName: 'android',
            colorName: 'green',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'BLoC Pattern',
            iconName: 'architecture',
            colorName: 'blue',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.expert,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'App Store Deployment',
            iconName: 'publish',
            colorName: 'green',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
          ),
        ],
      ),

      // Frontend Development
      const SkillCategoryModel(
        title: 'Frontend Development',
        description: 'Modern web technologies & responsive design',
        iconName: 'web',
        colorName: 'cyan',
        overallLevel: ProficiencyLevel.advanced,
        skills: [
          TechnicalSkillModel(
            name: 'Vue.js',
            iconName: 'vue',
            colorName: 'green',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'React',
            iconName: 'react',
            colorName: 'blue',
            yearsExperience: 1,
            proficiency: ProficiencyLevel.intermediate,
          ),
          TechnicalSkillModel(
            name: 'TypeScript',
            iconName: 'typescript',
            colorName: 'blue',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'JavaScript (ES6+)',
            iconName: 'javascript',
            colorName: 'orange',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'HTML5 & CSS3',
            iconName: 'html',
            colorName: 'orange',
            yearsExperience: 4,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'Responsive Design',
            iconName: 'design',
            colorName: 'purple',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
          ),
        ],
      ),

      // Backend & Database
      const SkillCategoryModel(
        title: 'Backend & Database',
        description: 'Server-side development & data management',
        iconName: 'storage',
        colorName: 'purple',
        overallLevel: ProficiencyLevel.advanced,
        skills: [
          TechnicalSkillModel(
            name: 'Laravel (PHP)',
            iconName: 'laravel',
            colorName: 'red',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'Node.js',
            iconName: 'nodejs',
            colorName: 'green',
            yearsExperience: 1,
            proficiency: ProficiencyLevel.intermediate,
          ),
          TechnicalSkillModel(
            name: 'MySQL',
            iconName: 'database',
            colorName: 'blue',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'MongoDB',
            iconName: 'database',
            colorName: 'green',
            yearsExperience: 1,
            proficiency: ProficiencyLevel.intermediate,
          ),
          TechnicalSkillModel(
            name: 'REST API Design',
            iconName: 'api',
            colorName: 'purple',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'API Integration',
            iconName: 'sync',
            colorName: 'cyan',
            yearsExperience: 4,
            proficiency: ProficiencyLevel.expert,
          ),
        ],
      ),

      // Cloud & DevOps
      const SkillCategoryModel(
        title: 'Cloud & DevOps',
        description: 'Cloud platforms, deployment & CI/CD',
        iconName: 'cloud',
        colorName: 'green',
        overallLevel: ProficiencyLevel.intermediate,
        skills: [
          TechnicalSkillModel(
            name: 'AWS',
            iconName: 'cloud',
            colorName: 'orange',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.intermediate,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'Firebase',
            iconName: 'firebase',
            colorName: 'orange',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'Docker',
            iconName: 'docker',
            colorName: 'blue',
            yearsExperience: 1,
            proficiency: ProficiencyLevel.intermediate,
          ),
          TechnicalSkillModel(
            name: 'CI/CD Pipelines',
            iconName: 'sync',
            colorName: 'green',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'GitHub Actions',
            iconName: 'github',
            colorName: 'grey',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.intermediate,
          ),
          TechnicalSkillModel(
            name: 'App Distribution',
            iconName: 'publish',
            colorName: 'green',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
          ),
        ],
      ),

      // Development Tools & Analytics
      const SkillCategoryModel(
        title: 'Development Tools',
        description: 'Design, debugging & performance monitoring',
        iconName: 'build',
        colorName: 'orange',
        overallLevel: ProficiencyLevel.advanced,
        skills: [
          TechnicalSkillModel(
            name: 'Figma',
            iconName: 'design',
            colorName: 'purple',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'Git & GitHub',
            iconName: 'github',
            colorName: 'grey',
            yearsExperience: 4,
            proficiency: ProficiencyLevel.expert,
            isFeatured: true,
          ),
          TechnicalSkillModel(
            name: 'Sentry (Error Tracking)',
            iconName: 'bug_report',
            colorName: 'red',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'UXCam (User Analytics)',
            iconName: 'analytics',
            colorName: 'blue',
            yearsExperience: 1,
            proficiency: ProficiencyLevel.intermediate,
          ),
          TechnicalSkillModel(
            name: 'App Analytics',
            iconName: 'analytics',
            colorName: 'green',
            yearsExperience: 2,
            proficiency: ProficiencyLevel.advanced,
          ),
          TechnicalSkillModel(
            name: 'Performance Optimization',
            iconName: 'speed',
            colorName: 'cyan',
            yearsExperience: 3,
            proficiency: ProficiencyLevel.advanced,
          ),
        ],
      ),
    ];
  }

  /// Get all featured technologies across categories
  static List<TechnicalSkillModel> getFeaturedTechnologies() {
    return getAllSkillCategories()
        .expand((category) => category.skills)
        .where((skill) => skill.isFeatured)
        .toList();
  }

  /// Get skills by proficiency level
  static List<TechnicalSkillModel> getSkillsByProficiency(
      ProficiencyLevel level) {
    return getAllSkillCategories()
        .expand((category) => category.skills)
        .where((skill) => skill.proficiency == level)
        .toList();
  }
}
