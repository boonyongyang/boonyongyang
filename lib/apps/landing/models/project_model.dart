class ProjectModel {
  final String title;
  final String subtitle;
  final String description;
  final List<String> achievements;
  final List<String> features;
  final List<String> technologies;
  final String? githubUrl;
  final String? liveUrl;
  final String status;
  final String metrics;
  final String iconName;
  final String colorName;

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

  static List<ProjectModel> getSampleProjects() {
    return [
      const ProjectModel(
        title: 'Involve Asia Mobile App',
        subtitle: 'iOS & Android • Affiliate Marketing Platform',
        description:
            'Comprehensive affiliate marketing mobile application enabling users to scale earnings by promoting 500+ global brands. Features advanced analytics, link management, and seamless commission tracking.',
        achievements: [
          'Successfully launched on App Store & Google Play in 3.5 months',
          'Built from scratch using Flutter with BLoC architecture',
          'Achieved 4.2★ rating with 50K+ downloads',
          '500+ global brand partnerships integrated',
          'Advanced affiliate link analytics and performance tracking',
        ],
        features: [
          'Multi-Link Affiliate Generation',
          'Real-time Performance Analytics',
          'Commission Tracking & Withdrawal',
          'Brand Partnership Management',
          'Conversion Rate Optimization',
          'Custom Link Naming & Organization',
          'Earnings Progress Visualization',
          'Fast Payment Processing',
        ],
        technologies: [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Analytics APIs',
          'Clean Architecture'
        ],
        iconName: 'trending_up',
        colorName: 'blue',
        status: 'Live in Production',
        metrics: '50K+ downloads • 4.2★ rating • 500+ brands',
      ),
      const ProjectModel(
        title: 'Cha Ching - Shop & Get Cashback',
        subtitle: 'iOS & Android • Cashback Shopping Platform',
        description:
            'Modern cashback shopping application connecting users with retailers to earn rewards on purchases. Features merchant integration, real-time cashback tracking, and streamlined checkout experience.',
        achievements: [
          'Built complete shopping platform with cashback system',
          'Integrated Affiliate APIs for Shopee MY',
          'Developed user-friendly shopping discovery interface',
          'Created robust backend infrastructure for transaction processing',
        ],
        features: [
          'Merchant Discovery & Search',
          'Real-time Cashback Tracking',
          'Secure Payment Processing',
          'Transaction History & Analytics',
          'Push Notifications & Alerts',
          'User Profile & Preferences',
          'Cashback Withdrawal System',
          'Shopping Cart & Checkout Flow',
        ],
        technologies: [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Payment APIs',
          'REST APIs',
          'Local Storage'
        ],
        iconName: 'shopping_bag',
        colorName: 'orange',
        status: 'Recently Launched',
        metrics: 'New product • Finding market fit',
      ),
    ];
  }

  static List<ProjectModel> getProductionApps() {
    return [
      const ProjectModel(
        title: 'Involve Asia Mobile App',
        subtitle: 'iOS & Android • Affiliate Marketing Platform',
        description:
            'Comprehensive affiliate marketing mobile application enabling users to scale earnings by promoting 500+ global brands. Features advanced analytics, link management, and seamless commission tracking.',
        achievements: [
          'Successfully launched on App Store & Google Play in 3.5 months',
          'Built from scratch using Flutter with BLoC architecture',
          'Achieved 4.2★ rating with 50K+ downloads',
          '500+ global brand partnerships integrated',
          'Advanced affiliate link analytics and performance tracking',
        ],
        features: [
          'Multi-Link Affiliate Generation',
          'Real-time Performance Analytics',
          'Commission Tracking & Withdrawal',
          'Brand Partnership Management',
          'Conversion Rate Optimization',
          'Custom Link Naming & Organization',
          'Earnings Progress Visualization',
          'Fast Payment Processing',
        ],
        technologies: [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Analytics APIs',
          'Clean Architecture'
        ],
        iconName: 'trending_up',
        colorName: 'blue',
        status: 'Live in Production',
        metrics: '50K+ downloads • 4.2★ rating • 500+ brands',
      ),
      const ProjectModel(
        title: 'Cha Ching - Shop & Get Cashback',
        subtitle: 'iOS & Android • Cashback Shopping Platform',
        description:
            'Modern cashback shopping application connecting users with retailers to earn rewards on purchases. Features merchant integration, real-time cashback tracking, and streamlined checkout experience.',
        achievements: [
          'Built complete shopping platform with cashback system',
          'Integrated Affiliate APIs for Shopee MY',
          'Developed user-friendly shopping discovery interface',
          'Created robust backend infrastructure for transaction processing',
        ],
        features: [
          'Merchant Discovery & Search',
          'Real-time Cashback Tracking',
          'Secure Payment Processing',
          'Transaction History & Analytics',
          'Push Notifications & Alerts',
          'User Profile & Preferences',
          'Cashback Withdrawal System',
          'Shopping Cart & Checkout Flow',
        ],
        technologies: [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Payment APIs',
          'REST APIs',
          'Local Storage'
        ],
        iconName: 'shopping_bag',
        colorName: 'orange',
        status: 'Recently Launched',
        metrics: 'New product • Finding market fit',
      ),
    ];
  }

  static List<ProjectModel> getPersonalProjects() {
    return [
      const ProjectModel(
        title: 'PocketFi - Personal Finance App',
        subtitle: 'Personal Project • Comprehensive Finance Management',
        description:
            'Full-featured personal finance application with expense tracking, receipt scanning, budget management, debt tracking, and collaborative wallet sharing. Built with advanced Flutter architecture patterns.',
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
      const ProjectModel(
        title: 'Flutter BLoC Starter Kit',
        subtitle: 'Architecture Template • Production-Ready Foundation',
        description:
            'Comprehensive Flutter starter template demonstrating clean architecture, BLoC patterns, and production-ready development practices. A showcase of how I approach building scalable Flutter applications from scratch.',
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
    ];
  }
}
