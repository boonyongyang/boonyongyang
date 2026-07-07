/// Project model for landing page portfolio projects
///
/// - Add new projects to getProductionApps() or getPersonalProjects()
/// - Update existing project details by modifying the project objects
/// - Use consistent iconName and colorName from landing_page_utils.dart
class ProjectModel {
  final String title; // Project name
  final String
      subtitle; // Platform & type (e.g., "iOS & Android • Finance App")
  final String description; // Detailed project description
  final List<String> achievements; // Key accomplishments
  final List<String> features; // Main features list
  final List<String> technologies; // Tech stack used
  final String? githubUrl; // GitHub repository URL (optional)
  final String? liveUrl; // Live app/demo URL (optional)
  final String status; // Current status (e.g., "Live in Production")
  final String metrics; // Key metrics (e.g., "50K+ downloads")
  final String iconName; // Icon identifier (see landing_page_utils.dart)
  final String colorName; // Color identifier (see landing_page_utils.dart)

  const ProjectModel({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.achievements,
    required this.features,
    required this.technologies,
    this.githubUrl,
    this.liveUrl,
    required this.status,
    required this.metrics,
    required this.iconName,
    required this.colorName,
  });

  /// Production applications.
  /// These are live apps serving real users in production
  ///
  /// To add a new production app:
  /// 1. Add a new ProjectModel object to the list below
  /// 2. Fill in all required fields
  /// 3. Ensure iconName and colorName exist in landing_page_utils.dart
  static List<ProjectModel> getProductionApps() {
    return [
      const ProjectModel(
        title: 'Involve Asia Mobile App',
        subtitle: 'iOS & Android • Affiliate Marketing Platform',
        description:
            'Affiliate marketing app for creating links, tracking performance, discovering brands, and managing commission workflows at production scale.',
        achievements: [
          'Launched on App Store and Google Play in 3.5 months',
          'Built from scratch with Flutter and BLoC architecture',
          'Reached 50K+ downloads with a 4.2 star rating',
        ],
        features: [
          'Generate and manage multiple affiliate links',
          'Track clicks and conversion events in real time',
          'Manage commissions and request withdrawals',
          'Visualize earnings with interactive charts',
          'Discover personalized offers and new brands',
          'Access detailed conversion and earnings reports',
          'Learn with integrated affiliate marketing Academy',
        ],
        technologies: [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Analytics APIs',
          'Mobile Attribution',
          'Clean Architecture'
        ],
        iconName: 'trending_up',
        colorName: 'orange',
        status: 'Live in Production',
        metrics: '50K+ downloads • 4.2★ rating • 500+ brands',
      ),
      const ProjectModel(
        title: 'Cha Ching - Shop & Get Cashback',
        subtitle: 'iOS & Android • Cashback Shopping Platform',
        description:
            'Cashback shopping app connecting users to retailers, affiliate offers, transaction tracking, and a cleaner purchase handoff.',
        achievements: [
          'Helped build the shopping platform and cashback flow',
          'Integrated affiliate APIs for Shopee MY',
          'Shipped shopping discovery, profile, and transaction surfaces',
        ],
        features: [
          'Merchant Discovery & Search',
          'Accurate Cashback Tracking',
          'Transaction History & Analytics',
          'Cashback Withdrawal System',
          'Push Notifications & Alerts',
          'Enhanced Paste Product Link Checkout Flow',
          'User Profile & Preferences',
        ],
        technologies: [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'REST APIs',
          'Clean Architecture',
        ],
        iconName: 'shopping_bag',
        colorName: 'blue',
        status: 'Recently Launched',
        metrics: 'New product • Finding market fit',
      ),
    ];
  }

  /// Personal and open-source projects.
  /// These provide compact references for technical decisions and patterns.
  ///
  /// To add a new personal project:
  /// 1. Add a new ProjectModel object to the list below
  /// 2. Include githubUrl for open source projects
  /// 3. Focus on technical achievements and learning outcomes
  static List<ProjectModel> getPersonalProjects() {
    return [
      const ProjectModel(
        title: 'Flutter BLoC Starter Kit',
        subtitle: 'Architecture Template • Production-Ready Foundation',
        description:
            'Reference starter for Flutter architecture decisions I use in real product work: feature boundaries, dependency injection, routing, storage, and tests.',
        achievements: [
          'Designed 2-layer clean architecture for optimal balance of simplicity and scalability',
          'Implemented comprehensive dependency injection with GetIt service locator',
          'Created type-safe environment configuration with Envied package',
          'Built offline-first data persistence with Hive local storage',
          'Established robust testing framework covering all architectural layers',
        ],
        features: [
          '2-Layer Clean Architecture',
          'BLoC/Cubit State Management',
          'Type-safe API Integration',
          'Offline-first Local Storage',
          'Environment Configuration',
          'Multi-language Localization',
          'Comprehensive Testing Suite',
          'Authentication & Route Protection',
          'Dynamic Theme Management',
          'Code Generation Pipeline',
          'Developer Tools & Linting',
          'Production-Ready Structure',
        ],
        technologies: [
          'Flutter BLoC',
          'GetIt DI',
          'Retrofit & Dio',
          'Hive Storage',
          'GoRouter',
          'Envied Config',
          'Freezed Models',
          'Mocktail Testing'
        ],
        iconName: 'architecture',
        colorName: 'purple',
        status: 'Open Source Template',
        metrics:
            'Architecture showcase • Developer template • GitHub available',
        githubUrl: 'https://github.com/boonyongyang/flutter-bloc-starter',
      ),
      const ProjectModel(
        title: 'FPV Overlay Toolbox',
        subtitle: 'Flutter Desktop • Video Overlay Utility',
        description:
            'Desktop utility for turning FPV flight footage plus telemetry into finished overlay videos with queue-driven rendering, diagnostics, packaging, and a headless CLI.',
        achievements: [
          'Built a real desktop workflow for macOS and Windows overlay rendering',
          'Added queue persistence, diagnostics, and DJI split-recording recovery',
          'Packaged release builds plus a headless CLI for batch processing',
        ],
        features: [
          'SRT and OSD overlay rendering',
          'Batch folder scanning and telemetry matching',
          'Persistent render queue',
          'Local FFmpeg and Python diagnostics',
          'macOS app update workflow',
          'Headless fpv-overlay CLI',
        ],
        technologies: [
          'Flutter',
          'Desktop',
          'FFmpeg',
          'CLI',
          'Release Automation',
          'Local Persistence',
        ],
        iconName: 'video_settings',
        colorName: 'red',
        status: 'Released Utility',
        metrics: 'Desktop app • CLI • GitHub releases',
        githubUrl: 'https://github.com/boonyongyang/fpv-overlay-app',
      ),
      const ProjectModel(
        title: 'PocketFi - Personal Finance App',
        subtitle: 'Personal Project • Comprehensive Finance Management',
        description:
            'Personal finance app concept covering budgets, receipt scanning, shared wallets, debt tracking, and savings workflows.',
        achievements: [
          'Comprehensive finance management with 10+ core features',
          'Implemented receipt scanning with text highlighting technology',
          'Built collaborative wallet sharing for joint expense management',
          'Created visual savings tracking with virtual piggy bank interface',
          'Designed modular architecture with Riverpod 2.0 state management',
        ],
        features: [
          'Receipt Scanning & OCR',
          'Expense & Income Tracking',
          'Budget Management & Alerts',
          'Debt Tracking & Payoff Progress',
          'Collaborative Wallet Sharing',
          'Visual Savings Goals',
          'Bill Management & Notifications',
          'Spending Trend Analytics',
          'Category-based Breakdowns',
          'Transaction Bookmarking',
          'Firebase Integration',
          'Clean Architecture Pattern',
        ],
        technologies: [
          'Flutter',
          'Riverpod 2.0',
          'Firebase Suite',
          'OCR Technology',
          'Clean Architecture',
          'Crashlytics'
        ],
        iconName: 'account_balance_wallet',
        colorName: 'green',
        status: 'Open Source Project',
        metrics: 'Personal project • Full feature set • GitHub available',
        githubUrl: 'https://github.com/boonyongyang/pocketfi',
      ),
    ];
  }
}
