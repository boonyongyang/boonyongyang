class WorkExperienceModel {
  final String jobTitle;
  final String company;
  final String duration;
  final String companyIconName;
  final String description;
  final List<String> keyImplementations;
  final List<String> technologies;
  final List<String> achievements;

  const WorkExperienceModel({
    required this.jobTitle,
    required this.company,
    required this.duration,
    required this.companyIconName,
    required this.description,
    required this.keyImplementations,
    required this.technologies,
    required this.achievements,
  });

  static WorkExperienceModel get current => const WorkExperienceModel(
        jobTitle: 'Mobile Engineer (Flutter)',
        company: 'IA',
        duration: 'May 2023 – Present (2 years and counting)',
        companyIconName: 'phone_android',
        description:
            'Led end-to-end mobile development for two production applications from architecture to App Store deployment. '
            'Owned complete technical architecture, implemented robust CI/CD pipelines, and delivered scalable Flutter solutions.',
        keyImplementations: [
          'Architected and built Involve Asia Mobile App from 0 to 50K+ downloads',
          'Designed clean architecture with BLoC pattern for scalable codebase',
          'Implemented CI/CD pipeline with automated testing and deployment',
          'Built comprehensive affiliate marketing system with real-time analytics',
          'Integrated Firebase suite for analytics, crashlytics, and notifications',
          'Delivered Cha Ching cashback platform with payment gateway integration',
        ],
        technologies: [
          'Flutter & Dart',
          'BLoC/Cubit State Management',
          'Firebase Suite (Analytics, Crashlytics, etc.)',
          'REST API Integration',
          'CI/CD with GitHub Actions',
          'App Store & Play Store Deployment',
        ],
        achievements: [
          '2 apps successfully launched to production',
          '50K+ combined downloads across platforms',
          '4.2★ average rating on app stores',
          'Zero critical production bugs in 18+ months',
          'Reduced app crash rate to <0.1%',
          'Improved app performance by 40%',
        ],
      );
}
