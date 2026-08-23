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
  static const String email = 'boonyongyang@gmail.com';
  static const String emailSubject = 'Hello';

  // Current work
  static const String currentCompany = 'IA';
  static const String currentPosition = 'Mobile Engineer (Flutter)';
  static const String workDuration = 'June 2023 to Present';

  // Proof points
  static const String professionalSummary =
      'I build Flutter apps from early product shape to store release: architecture, UI, CI/CD, analytics, and the unglamorous details that keep production apps maintainable.';

  // Links
  static const String githubUrl = 'https://github.com/boonyongyang';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/boon-yong-yang-64096b1aa/';
  static const String appUrl = 'https://app.boonyongyang.com';

  // Footer
  static const String copyrightYear = '2026';
  static const String contactSubtitle =
      'Available for focused Flutter product work, architecture cleanup, and release-ready mobile delivery.';

  // Experience timeline
  static const List<QuickExperienceImplementation> experienceImplementations = [
    QuickExperienceImplementation(
      title: 'Architecture and delivery',
      description:
          'Set up practical app foundations that could move quickly without turning brittle.',
      details: [
        'Applied BLoC feature-first patterns for fast delivery cycles',
        'Kept clean architecture pragmatic instead of ceremony-heavy',
        'Built foundations that continued to support production growth',
      ],
    ),
    QuickExperienceImplementation(
      title: 'Core app infrastructure',
      description:
          'Built the everyday systems behind stable mobile product work.',
      details: [
        'Implemented BLoC/Cubit state with repository boundaries',
        'Built API layers with typed models and predictable errors',
        'Handled navigation, deep links, caching, and offline resilience',
      ],
    ),
    QuickExperienceImplementation(
      title: 'Release and quality',
      description:
          'Kept releases repeatable with testing, automation, and production feedback loops.',
      details: [
        'Built CI/CD pipelines with Fastlane and Codemagic',
        'Used unit, widget, and integration tests where risk justified it',
        'Profiled slow paths with Dart DevTools and production signals',
      ],
    ),
    QuickExperienceImplementation(
      title: 'Product integrations',
      description:
          'Connected mobile product surfaces to the services that make them useful.',
      details: [
        'Integrated Firebase, analytics, attribution, and notification services',
        'Built app flows around affiliate, cashback, and media workflows',
        'Worked across Vue and Laravel surfaces when mobile needed backend support',
      ],
    ),
  ];

  // Capability rows
  static const List<QuickSkillCategory> skillCategories = [
    QuickSkillCategory(
      title: 'Mobile product',
      level: 'Expert',
      skills: ['Flutter', 'Dart', 'iOS', 'Android', 'BLoC', 'Firebase'],
    ),
    QuickSkillCategory(
      title: 'Product UI',
      level: 'Advanced',
      skills: ['Responsive UI', 'Vue.js', 'TypeScript', 'Design systems'],
    ),
    QuickSkillCategory(
      title: 'Integrations',
      level: 'Advanced',
      skills: ['REST APIs', 'Laravel', 'MySQL', 'Affiliate APIs'],
    ),
    QuickSkillCategory(
      title: 'Release systems',
      level: 'Intermediate',
      skills: ['Fastlane', 'Codemagic', 'Shorebird', 'CI/CD', 'Sentry'],
    ),
    QuickSkillCategory(
      title: 'Workflow',
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
      matchTitleContains: 'cashiu',
      appStoreUrl:
          'https://apps.apple.com/my/app/cashiu-everyday-cashback/id6745090543',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.cmv.chaching&hl=en&gl=MY',
    ),
  ];

  // Current metrics
  static const Map<String, String> currentMetrics = {
    'totalApps': '2',
    'storeCoverage': 'iOS + Android',
    'advertiserScale': '500+',
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
/// - PersonalInfoModel uses name, role, availability, and summary copy.
/// - WorkExperienceModel uses company, position, duration, and role summary.
/// - FooterInfoModel uses copyright and contact copy.
///
/// Typical update path:
/// - Update role/status/metrics here first.
/// - Update app and project details in project_model.dart.
/// - Rebuild the landing target.
