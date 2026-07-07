import '../models/quick_content_models.dart';

/// Quick-edit configuration for common landing page content updates.
///
/// Keep this file concise. The landing UI is intentionally editorial and
/// scan-friendly, so source copy should stay short.

class QuickConfig {
  // Personal information
  static const String fullName = 'Boon Yong Yang';
  static const String currentRole =
      'Flutter engineer shipping production mobile products';
  static const String headerTitle = fullName;
  static const String headerSubtitle = 'Flutter engineer';
  static const String workStatus =
      'Available for Work'; // Available for Work, Currently Employed, etc.
  static const String statusType = 'available'; // available, busy, unavailable
  static const String email = 'boonyongyang@gmail.com';
  static const String emailSubject = 'Hello';

  // Current work
  static const String currentCompany = 'IA';
  static const String currentPosition = 'Mobile Engineer (Flutter)';
  static const String workDuration =
      'June 2023 – Present (2 years and counting)'; // Update as needed

  // Proof points
  static const String achievementBanner =
      '2 production apps shipped / 50K+ downloads / 4+ years Flutter';
  static const String professionalSummary =
      'I build Flutter apps from early product shape to store release: architecture, UI, CI/CD, analytics, and the unglamorous details that keep production apps maintainable.';

  // Links
  static const String githubUrl = 'https://github.com/boonyongyang';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/boon-yong-yang-64096b1aa/';
  static const String appUrl = 'https://app.boonyongyang.dev';

  // Main production app reference
  static const String mainAppName = 'Involve Asia Mobile App';
  static const String mainAppMetrics =
      '50K+ downloads • 4.2★ rating • 500+ brands';

  // Footer
  static const String copyrightYear = '2025';
  static const String contactSubtitle =
      'Available for focused Flutter product work, architecture cleanup, and release-ready mobile delivery.';

  // Technical stack
  static const List<String> primaryTechnologies = [
    'Flutter',
    'BLoC/Cubit',
    'Firebase',
    'Clean Architecture',
    'CI/CD',
  ];

  static const List<String> currentProjects = [
    'Involve Asia Mobile App',
    'Cha Ching - Shop & Get Cashback',
  ];

  // Experience timeline
  static const List<QuickExperienceImplementation> experienceImplementations = [
    QuickExperienceImplementation(
      title: 'Architecture and delivery',
      iconName: 'architecture',
      description:
          'Set up practical app foundations that could move quickly without turning brittle.',
      details: [
        'Applied BLoC feature-first patterns for fast delivery cycles',
        'Kept clean architecture pragmatic instead of ceremony-heavy',
        'Built foundations that continued to support production growth',
      ],
      technologies: [
        'Flutter',
        'BLoC/Cubit',
        'Clean Architecture',
        'App Store',
        'Google Play',
      ],
      showStoreLinks: true,
    ),
    QuickExperienceImplementation(
      title: 'Core app infrastructure',
      iconName: 'build',
      description:
          'Built the everyday systems behind stable mobile product work.',
      details: [
        'Implemented BLoC/Cubit state with repository boundaries',
        'Built API layers with typed models and predictable errors',
        'Handled navigation, deep links, caching, and offline resilience',
      ],
      technologies: [
        'BLoC',
        'Repository Pattern',
        'GetIt DI',
        'GoRouter',
        'Hive',
        'Dio'
      ],
    ),
    QuickExperienceImplementation(
      title: 'Release and quality',
      iconName: 'sync',
      description:
          'Kept releases repeatable with testing, automation, and production feedback loops.',
      details: [
        'Built CI/CD pipelines with Fastlane and Codemagic',
        'Used unit, widget, and integration tests where risk justified it',
        'Profiled slow paths with Dart DevTools and production signals',
      ],
      technologies: [
        'Fastlane',
        'Codemagic',
        'Shorebird',
        'Testing',
        'Dart DevTools'
      ],
    ),
    QuickExperienceImplementation(
      title: 'Product integrations',
      iconName: 'integration_instructions',
      description:
          'Connected mobile product surfaces to the services that make them useful.',
      details: [
        'Integrated Firebase, analytics, attribution, and notification services',
        'Built app flows around affiliate, cashback, and media workflows',
        'Worked across Vue and Laravel surfaces when mobile needed backend support',
      ],
      technologies: [
        'Firebase',
        'Rive',
        'Lottie',
        'AWS S3',
        'Vue.js',
        'Laravel'
      ],
    ),
  ];

  // Capability rows
  static const List<QuickSkillCategory> skillCategories = [
    QuickSkillCategory(
      title: 'Mobile product',
      iconName: 'phone_android',
      colorName: 'blue',
      level: 'Expert',
      skills: ['Flutter', 'Dart', 'iOS', 'Android', 'BLoC', 'Firebase'],
    ),
    QuickSkillCategory(
      title: 'Product UI',
      iconName: 'web',
      colorName: 'cyan',
      level: 'Advanced',
      skills: ['Responsive UI', 'Vue.js', 'TypeScript', 'Design systems'],
    ),
    QuickSkillCategory(
      title: 'Integrations',
      iconName: 'storage',
      colorName: 'purple',
      level: 'Advanced',
      skills: ['REST APIs', 'Laravel', 'MySQL', 'Affiliate APIs'],
    ),
    QuickSkillCategory(
      title: 'Release systems',
      iconName: 'cloud_queue',
      colorName: 'green',
      level: 'Intermediate',
      skills: ['Fastlane', 'Codemagic', 'Shorebird', 'CI/CD', 'Sentry'],
    ),
    QuickSkillCategory(
      title: 'Workflow',
      iconName: 'build',
      colorName: 'orange',
      level: 'Advanced',
      skills: ['Figma', 'Git', 'Postman', 'Dart DevTools', 'Analytics'],
    ),
  ];

  // Store links used in production app panels
  static const List<QuickStoreLinks> productionStoreLinks = [
    QuickStoreLinks(
      matchTitleContains: 'involve',
      appStoreUrl: 'https://apps.apple.com/my/app/involve-asia/id6469589952',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=asia.involve.app&hl=en',
    ),
    QuickStoreLinks(
      matchTitleContains: 'cha ching',
      appStoreUrl:
          'https://apps.apple.com/us/app/cha-ching-shop-get-cashback/id6745090543',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.cmv.chaching&hl=en',
    ),
  ];

  // Current metrics
  static const Map<String, String> currentMetrics = {
    'totalApps': '2',
    'totalDownloads': '50K+',
    'averageRating': '4.2★',
    'yearsExperience': '4+',
    'productionApps': '2',
  };

  static ({String appStore, String playStore}) storeLinksForProject(
    String projectTitle,
  ) {
    final normalizedTitle = projectTitle.toLowerCase();
    for (final link in productionStoreLinks) {
      if (normalizedTitle.contains(link.matchTitleContains)) {
        return (appStore: link.appStoreUrl, playStore: link.playStoreUrl);
      }
    }
    return (appStore: '', playStore: '');
  }
}

/// Connected models:
/// - PersonalInfoModel uses name, role, status, email, and summary copy.
/// - WorkExperienceModel uses company, position, duration, and metrics.
/// - SocialLinkModel uses GitHub, LinkedIn, and email links.
/// - FooterInfoModel uses copyright and contact copy.
///
/// Typical update path:
/// - Update role/status/metrics here first.
/// - Update app and project details in project_model.dart.
/// - Rebuild the landing target.
