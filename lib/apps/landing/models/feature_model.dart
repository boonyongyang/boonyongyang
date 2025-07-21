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
          'State management with BLoC/Cubit',
          'Modular and reusable components',
          'Layered architecture with clear separation of concerns',
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
          'Image & asset optimization',
          'Smooth animations and transitions',
        ],
      ),
      const FeatureModel(
        iconName: 'security',
        title: 'Quality & Security',
        description:
            'Thorough testing, security best practices, and automated CI/CD pipelines.',
        colorName: 'orange',
        items: [
          'Unit, widget, and integration tests',
          'Mobile security best practices, secure token management & API key protection',
          'CICD with Codemagic and Fastlane',
          'Code signing & app distribution',
          'User data protection and privacy compliance',
        ],
      ),
      const FeatureModel(
        iconName: 'integration_instructions',
        title: 'Seamless Integrations',
        description: 'Connects easily with modern APIs and cloud services.',
        colorName: 'purple',
        items: [
          'Entire Firebase suite (Analytics, Messaging, Remote Config, Crashlytics, etc.)',
          'Push notifications & real-time updates',
          'Deeplinking & Notification routing for smart navigation',
          'Force App update management',
          'Dynamic content delivery',
        ],
      ),
    ];
  }
}
