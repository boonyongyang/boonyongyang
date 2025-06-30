class FeatureModel {
  final String iconName;
  final String title;
  final String description;
  final String colorName;
  final List<String> items;

  const FeatureModel({
    required this.iconName,
    required this.title,
    required this.description,
    required this.colorName,
    required this.items,
  });

  static List<FeatureModel> getAllFeatures() {
    return [
      const FeatureModel(
        iconName: 'architecture',
        title: 'Scalable Architecture',
        description: 'Clean Architecture with BLoC patterns',
        colorName: 'blue',
        items: [
          'Feature-first structure',
          'Repository pattern',
          'Dependency injection',
        ],
      ),
      const FeatureModel(
        iconName: 'speed',
        title: 'Performance',
        description: '60fps smooth experiences',
        colorName: 'green',
        items: [
          'Memory optimization',
          'Widget efficiency',
          'DevTools profiling',
        ],
      ),
      const FeatureModel(
        iconName: 'security',
        title: 'Quality Assurance',
        description: 'Comprehensive testing & CI/CD',
        colorName: 'orange',
        items: [
          'Automated testing',
          'Patrol integration',
          'OTA updates',
        ],
      ),
      const FeatureModel(
        iconName: 'integration_instructions',
        title: 'Integrations',
        description: 'Modern APIs & services',
        colorName: 'purple',
        items: [
          'Firebase suite',
          'Analytics',
          'Push notifications',
        ],
      ),
    ];
  }
}
