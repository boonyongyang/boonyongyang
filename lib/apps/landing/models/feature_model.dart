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
        title: 'Robust Architecture',
        description:
            'Maintainable, scalable, and testable codebase using Clean Architecture and BLoC.',
        colorName: 'blue',
        items: [
          'Feature-first folder structure',
          'Repository & service abstraction',
          'Built-in dependency injection',
        ],
      ),
      const FeatureModel(
        iconName: 'speed',
        title: 'High Performance',
        description: 'Optimized for smooth 60fps experiences across devices.',
        colorName: 'green',
        items: [
          'Efficient widget trees',
          'Memory & resource optimization',
          'Performance profiling with DevTools',
        ],
      ),
      const FeatureModel(
        iconName: 'security',
        title: 'Quality & Reliability',
        description: 'Thorough testing and automated CI/CD pipelines.',
        colorName: 'orange',
        items: [
          'Unit, widget, and integration tests',
          'Continuous integration with Codemagic',
          'Automated deployment (Fastlane)',
        ],
      ),
      const FeatureModel(
        iconName: 'integration_instructions',
        title: 'Seamless Integrations',
        description: 'Connects easily with modern APIs and cloud services.',
        colorName: 'purple',
        items: [
          'Firebase (Auth, Firestore, Analytics, etc.)',
          'RESTful & GraphQL APIs',
          'Push notifications & real-time updates',
        ],
      ),
    ];
  }
}
