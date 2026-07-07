class QuickSkillCategory {
  final String title;
  final String iconName;
  final String colorName;
  final String level;
  final List<String> skills;

  const QuickSkillCategory({
    required this.title,
    required this.iconName,
    required this.colorName,
    required this.level,
    required this.skills,
  });
}

class QuickStoreLinks {
  final String matchTitleContains;
  final String appStoreUrl;
  final String playStoreUrl;

  const QuickStoreLinks({
    required this.matchTitleContains,
    required this.appStoreUrl,
    required this.playStoreUrl,
  });
}

class QuickExperienceImplementation {
  final String title;
  final String iconName;
  final String description;
  final List<String> details;
  final List<String> technologies;
  final bool showStoreLinks;

  const QuickExperienceImplementation({
    required this.title,
    required this.iconName,
    required this.description,
    required this.details,
    required this.technologies,
    this.showStoreLinks = false,
  });
}
