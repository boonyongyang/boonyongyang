import 'dart:core';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _launchApp() {
    // Navigate to the main app
    // In production, this would be a different subdomain
    const appUrl = String.fromEnvironment('APP_URL',
        defaultValue: 'https://app.yourdomain.com');

    if (appUrl.startsWith('http')) {
      // Production: redirect to subdomain
      launchUrl(Uri.parse(appUrl));
    } else {
      // Development: show dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Launching App'),
          content: const Text(
            'In production, this would redirect to app.yourdomain.com\n\n'
            'For development, run:\nflutter run -d chrome --target=lib/main_app.dart',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _launchGitHub() async {
    final uri = Uri.parse('https://github.com/boonyongyang');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _launchLinkedIn() async {
    final uri = Uri.parse('https://linkedin.com/in/boonyongyang');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.primary.withOpacity(0.1),
                  colorScheme.secondary.withOpacity(0.05),
                ],
              ),
            ),
            child: Column(
              children: [
                _buildHeader(),
                _buildHeroSection(),
                _buildWorkExperienceSection(),
                _buildPassionProjectsSection(),
                _buildFeaturesSection(),
                _buildFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.95),
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo/Brand
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.code,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Boon Yong Yang',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  if (!isMobile)
                    Text(
                      'Flutter Expert',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.6),
                      ),
                    ),
                ],
              ),
            ],
          ),

          // Navigation/Actions
          Row(
            children: [
              if (!isMobile) ...[
                TextButton(
                  onPressed: () => _launchEmail(),
                  child: Text(
                    'Contact',
                    style: TextStyle(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
              ],
              IconButton(
                onPressed: _launchGitHub,
                icon: const Icon(Icons.code),
                tooltip: 'GitHub',
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: _launchLinkedIn,
                icon: const Icon(Icons.business),
                tooltip: 'LinkedIn',
                style: IconButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 40 : 80,
      ),
      constraints: const BoxConstraints(minHeight: 500),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Enhanced avatar with professional styling
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: isMobile ? 60 : 80,
              backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
              child: Icon(
                Icons.person,
                size: isMobile ? 60 : 80,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Name with enhanced typography
          Text(
            'Boon Yong Yang',
            style: theme.textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 32 : null,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),

          // Professional title with status indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'Available for Work',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text(
            'Mobile Engineer & Flutter Expert',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              fontSize: isMobile ? 18 : null,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),

          // Key achievements banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary.withOpacity(0.1),
                  theme.colorScheme.secondary.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(
                color: theme.colorScheme.primary.withOpacity(0.2),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '2 Production Apps • Live on App Store • 1.8+ Years Experience',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Enhanced description with better formatting
          Container(
            constraints:
                BoxConstraints(maxWidth: isMobile ? double.infinity : 600),
            child: Text(
              'Specialized in Flutter mobile development with 1.8+ years delivering production apps.\n'
              'Expert in architectural patterns, CI/CD pipelines, and performance optimization.\n'
              'Passionate about clean code, scalable solutions, and exceptional user experiences.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),

          // Enhanced action buttons
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: _launchApp,
                icon: const Icon(Icons.launch),
                label: const Text('Launch Live App'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              OutlinedButton.icon(
                onPressed: _launchGitHub,
                icon: const Icon(Icons.code),
                label: const Text('View GitHub'),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => _launchEmail(),
                icon: const Icon(Icons.email),
                label: const Text('Get Resume'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkExperienceSection() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 40 : 80,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Work Experience',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 48),
          _buildExperienceCard(),
        ],
      ),
    );
  }

  Widget _buildExperienceCard() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 1024;

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with company info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.phone_android,
                    size: 30,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Engineer (Flutter)',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'IA • May 2023 – Present (1 year 8 months)',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Led end-to-end mobile development for two production applications from architecture to App Store deployment. '
                        'Owned complete technical architecture, implemented robust CI/CD pipelines, and delivered scalable Flutter solutions.',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Technical implementations
            Text(
              'Key Technical Implementations',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            if (isMobile)
              Column(
                children: _buildImplementationCards(),
              )
            else
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: _buildImplementationCards(),
              ),

            const SizedBox(height: 32),

            // Technologies used
            _buildTechnologiesSection(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildImplementationCards() {
    final implementations = [
      {
        'title': 'Mobile App Architecture & Delivery',
        'icon': Icons.architecture,
        'description':
            'Architected and delivered two production Flutter applications from concept to App Store deployment using strategic architectural patterns.',
        'details': [
          'Applied BLoC Feature First for rapid 3.5-month launch cycle',
          'Implemented Clean Architecture for scalable, maintainable codebases',
          'Successfully launched both apps on Apple App Store & Google Play Store',
          'Owned complete top-down technical architecture decisions',
        ],
        'tech': [
          'Flutter',
          'BLoC/Cubit',
          'Clean Architecture',
          'App Store',
          'Google Play'
        ],
      },
      {
        'title': 'Core Development Infrastructure',
        'icon': Icons.settings_system_daydream,
        'description':
            'Built robust foundational systems including state management, networking, navigation, and local data persistence with performance optimization.',
        'details': [
          'Implemented BLoC/Cubit state management with Repository pattern',
          'Built network layer with Dio, Retrofit, Freezed for API consistency',
          'Managed complex navigation with GoRouter and deep linking',
          'Utilized Hive for high-performance local data caching',
        ],
        'tech': [
          'BLoC',
          'Repository Pattern',
          'Get_it DI',
          'GoRouter',
          'Hive',
          'Dio'
        ],
      },
      {
        'title': 'CI/CD & Quality Assurance Pipeline',
        'icon': Icons.sync,
        'description':
            'Engineered comprehensive development workflows with automated testing, deployment pipelines, and monitoring systems.',
        'details': [
          'Built robust CI/CD pipelines using Fastlane and Codemagic',
          'Integrated Shorebird for OTA updates without app store releases',
          'Implemented comprehensive unit, widget, and integration testing (Patrol)',
          'Optimized performance using Dart DevTools profiling',
        ],
        'tech': [
          'Fastlane',
          'Codemagic',
          'Shorebird',
          'Patrol Testing',
          'Dart DevTools'
        ],
      },
      {
        'title': 'Advanced Features & Backend Integration',
        'icon': Icons.integration_instructions,
        'description':
            'Developed complex UI/UX features, third-party integrations, and collaborated on full-stack optimizations including recent S3 and notification systems.',
        'details': [
          'Built custom animations with Rive & Lottie, offline sync & localization',
          'Integrated Firebase suite, UXCam analytics, and Singular attribution',
          'Optimized API queries for faster response times (recent)',
          'Implemented S3 image storage and Vue.js 3 admin panel features (recent)',
        ],
        'tech': [
          'Firebase',
          'Rive',
          'Lottie',
          'UXCam',
          'AWS S3',
          'Vue.js 3',
          'Laravel'
        ],
      },
    ];

    return implementations.map((impl) {
      return SizedBox(
        width: MediaQuery.of(context).size.width < 1024 ? double.infinity : 300,
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      impl['icon'] as IconData,
                      size: 24,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        impl['title'] as String,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  impl['description'] as String,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.8),
                      ),
                ),
                const SizedBox(height: 16),

                // Implementation details
                ...((impl['details'] as List<String>).map((detail) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            detail,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()),

                const SizedBox(height: 16),

                // Technologies
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: (impl['tech'] as List<String>).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        tech,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTechnologiesSection() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technology Stack',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Technical progression through my development journey including recent implementations',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 32),

        // Timeline-style technology progression
        _buildTechTimeline(),
      ],
    );
  }

  // Mobile Development - Showcase as mobile app development workflow
  Widget _buildMobileDevelopmentSection() {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withOpacity(0.05),
            theme.colorScheme.secondary.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.1),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        theme.colorScheme.primary,
                        theme.colorScheme.primary.withOpacity(0.8)
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.phone_android,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mobile Development',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      Text(
                        'Cross-platform apps for iOS & Android',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Mobile app development flow visualization
            Row(
              children: [
                // Phone mockup
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.2),
                          width: 3),
                    ),
                    child: Column(
                      children: [
                        // Status bar
                        Container(
                          height: 24,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                      color: theme.colorScheme.primary,
                                      shape: BoxShape.circle)),
                              const Spacer(),
                              Text('Flutter App',
                                  style: theme.textTheme.bodySmall),
                              const Spacer(),
                              Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle)),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        // App content area
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color:
                                  theme.colorScheme.primary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.widgets,
                                    color: theme.colorScheme.primary, size: 32),
                                const SizedBox(height: 8),
                                Text('Material 3',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // Technology stack
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTechStack('Core Framework', ['Flutter', 'Dart'],
                          theme.colorScheme.primary),
                      const SizedBox(height: 12),
                      _buildTechStack(
                          'Architecture',
                          ['BLoC/Cubit', 'Clean Architecture'],
                          theme.colorScheme.secondary),
                      const SizedBox(height: 12),
                      _buildTechStack(
                          'Platforms',
                          ['iOS', 'Android', 'App Store', 'Google Play'],
                          theme.colorScheme.tertiary),
                      const SizedBox(height: 12),
                      _buildTechStack('Navigation',
                          ['GoRouter', 'Deep Linking'], Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Development & Quality - Showcase as testing pyramid and quality metrics
  Widget _buildDevelopmentQualitySection() {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.green.withOpacity(0.05),
            theme.colorScheme.primary.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.green, Colors.green.withOpacity(0.8)]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.bug_report,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Development & Quality',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                      Text(
                        'Testing, debugging & performance optimization',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Testing pyramid and tools
            Row(
              children: [
                // Testing pyramid
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text('Testing Pyramid',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      _buildTestingLevel(
                          'Integration', 'Patrol', Colors.red.shade300, 120),
                      const SizedBox(height: 4),
                      _buildTestingLevel('Widget Testing', 'Flutter Test',
                          Colors.orange.shade300, 160),
                      const SizedBox(height: 4),
                      _buildTestingLevel('Unit Testing', 'Dart Test',
                          Colors.green.shade300, 200),
                    ],
                  ),
                ),

                const SizedBox(width: 24),

                // Development tools
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDevTool(
                          'Performance',
                          Icons.speed,
                          ['Dart DevTools', 'Performance Profiling'],
                          Colors.blue),
                      const SizedBox(height: 12),
                      _buildDevTool(
                          'Data & API',
                          Icons.api,
                          ['Dio', 'Retrofit', 'Freezed', 'Hive'],
                          Colors.purple),
                      const SizedBox(height: 12),
                      _buildDevTool('UI/UX', Icons.palette,
                          ['Rive', 'Lottie', 'Custom Painters'], Colors.pink),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // DevOps & Infrastructure - Showcase as deployment pipeline
  Widget _buildDevOpsInfrastructureSection() {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.withOpacity(0.05),
            Colors.cyan.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue.withOpacity(0.8)]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.cloud_queue,
                      color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DevOps & Infrastructure',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Text(
                        'CI/CD, monitoring & cloud infrastructure',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // CI/CD Pipeline visualization
            Column(
              children: [
                // Pipeline flow
                Row(
                  children: [
                    _buildPipelineStep('Code', Icons.code, Colors.grey, true),
                    _buildPipelineArrow(),
                    _buildPipelineStep(
                        'Build', Icons.build, Colors.orange, true),
                    _buildPipelineArrow(),
                    _buildPipelineStep(
                        'Test', Icons.check_circle, Colors.green, true),
                    _buildPipelineArrow(),
                    _buildPipelineStep(
                        'Deploy', Icons.rocket_launch, Colors.blue, true),
                  ],
                ),
                const SizedBox(height: 16),

                // Tools and services
                Row(
                  children: [
                    Expanded(
                      child: _buildInfrastructureCard(
                          'CI/CD',
                          Icons.sync,
                          ['Fastlane', 'Codemagic', 'Shorebird OTA'],
                          Colors.orange),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfrastructureCard(
                          'Firebase',
                          Icons.whatshot,
                          ['Crashlytics', 'FCM', 'Remote Config'],
                          Colors.red),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfrastructureCard(
                          'Analytics',
                          Icons.analytics,
                          ['UXCam', 'Singular', 'Sentry'],
                          Colors.purple),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildInfrastructureCard('Cloud', Icons.cloud,
                          ['AWS S3', 'Supabase', 'Image Storage'], Colors.blue),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Backend & Full-Stack - Showcase as system architecture
  Widget _buildBackendFullStackSection() {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.deepPurple.withOpacity(0.05),
            Colors.indigo.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: Colors.deepPurple.withOpacity(0.2), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.deepPurple,
                      Colors.deepPurple.withOpacity(0.8)
                    ]),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:
                      const Icon(Icons.storage, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Backend & Full-Stack',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                      Text(
                        'Server-side development & database management',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Full-stack architecture diagram
            Column(
              children: [
                // Frontend layer
                _buildArchitectureLayer(
                    'Frontend',
                    Icons.web,
                    ['Vue.js 3', 'TypeScript', 'Admin Panels'],
                    Colors.green,
                    theme),
                const SizedBox(height: 8),
                _buildArchitectureConnector(),

                // Backend layer
                _buildArchitectureLayer('Backend APIs', Icons.api,
                    ['Laravel', 'Adonis.js'], Colors.orange, theme),
                const SizedBox(height: 8),
                _buildArchitectureConnector(),

                // Database layer
                Row(
                  children: [
                    Expanded(
                        child: _buildDatabaseCard(
                            'Redis', Icons.memory, Colors.red)),
                  ],
                ),
                const SizedBox(height: 12),

                // Optimization tools
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: Colors.deepPurple.withOpacity(0.2)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.tune,
                          color: Colors.deepPurple, size: 20),
                      const SizedBox(width: 8),
                      Text(
                          'Performance Optimization: Query Optimization, Profiling',
                          style: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.deepPurple.shade700)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widgets for the contextual sections
  Widget _buildTechStack(String title, List<String> techs, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(techs.join(' • '),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: color.withOpacity(0.8))),
        ],
      ),
    );
  }

  Widget _buildTestingLevel(
      String type, String tool, Color color, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(type,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 12)),
          Text(tool, style: const TextStyle(color: Colors.white, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildDevTool(
      String category, IconData icon, List<String> tools, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(category,
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                Text(tools.join(' • '),
                    style: theme.textTheme.bodySmall?.copyWith(color: color)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPipelineStep(
      String label, IconData icon, Color color, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isActive ? color : color.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w600, color: color)),
        ],
      ),
    );
  }

  Widget _buildPipelineArrow() {
    return SizedBox(
      width: 20,
      child: const Icon(Icons.arrow_forward, size: 16, color: Colors.grey),
    );
  }

  Widget _buildInfrastructureCard(
      String title, IconData icon, List<String> tools, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(title,
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          ...tools.map((tool) => Text(tool,
              style: theme.textTheme.bodySmall?.copyWith(color: color),
              textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildArchitectureLayer(String title, IconData icon,
      List<String> techs, Color color, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 12),
          Text(title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const Spacer(),
          Text(techs.join(' • '),
              style: theme.textTheme.bodyMedium?.copyWith(color: color)),
        ],
      ),
    );
  }

  Widget _buildArchitectureConnector() {
    return Container(
      width: 2,
      height: 16,
      color: Colors.grey.withOpacity(0.5),
      margin: const EdgeInsets.symmetric(horizontal: 8),
    );
  }

  Widget _buildDatabaseCard(String name, IconData icon, Color color) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 4),
          Text(name,
              style: theme.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildVariedTechCategoryCard(BuildContext context, String categoryName,
      List<String> technologies, int index) {
    // Different styles based on index
    switch (index % 4) {
      case 0:
        return _buildListStyleCategory(context, categoryName, technologies);
      case 1:
        return _buildBadgeStyleCategory(context, categoryName, technologies);
      case 2:
        return _buildGridStyleCategory(context, categoryName, technologies);
      case 3:
        return _buildProgressStyleCategory(context, categoryName, technologies);
      default:
        return _buildListStyleCategory(context, categoryName, technologies);
    }
  }

  // Style 1: Clean list with icons
  Widget _buildListStyleCategory(
      BuildContext context, String categoryName, List<String> technologies) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.code,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  categoryName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...technologies.map((tech) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      tech,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Style 2: Modern badges with gradient backgrounds
  Widget _buildBadgeStyleCategory(
      BuildContext context, String categoryName, List<String> technologies) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.secondary.withOpacity(0.1),
            theme.colorScheme.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.secondary.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.secondary,
                  theme.colorScheme.secondary.withOpacity(0.8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              categoryName,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: technologies.map((tech) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.secondary.withOpacity(0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.secondary.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  tech,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Style 3: Grid layout with numbered items
  Widget _buildGridStyleCategory(
      BuildContext context, String categoryName, List<String> technologies) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.category,
                size: 20,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                categoryName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: technologies.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        technologies[index],
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Style 4: Progress bar style with skill levels
  Widget _buildProgressStyleCategory(
      BuildContext context, String categoryName, List<String> technologies) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.primary.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  categoryName,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ...technologies.asMap().entries.map((entry) {
            int index = entry.key;
            String tech = entry.value;
            double progress =
                0.7 + (index % 3) * 0.1; // Vary progress for visual interest

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tech,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(progress * 100).toInt()}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Container(
                    height: 6,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outline.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.secondary,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTechCategoryCard(
      BuildContext context, String categoryName, List<String> technologies) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Text(
            categoryName,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 12),
          // Technology chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: technologies.map((tech) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                child: Text(
                  tech,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPassionProjectsSection() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 40 : 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Featured Projects',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              'Real-world applications showcasing technical expertise and problem-solving',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: _buildProjectCards(),
            )
          else
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 24,
              mainAxisSpacing: 24,
              children: _buildProjectCards(),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildProjectCards() {
    final projects = [
      {
        'title': 'Involve Asia Mobile App',
        'subtitle': 'iOS & Android • Affiliate Marketing Platform',
        'description':
            'Comprehensive affiliate marketing mobile application enabling users to scale earnings by promoting 500+ global brands. Features advanced analytics, link management, and seamless commission tracking.',
        'achievements': [
          'Successfully launched on App Store & Google Play in 3.5 months',
          'Built from scratch using Flutter with BLoC architecture',
          'Achieved 4.2★ rating with 50K+ downloads',
          '500+ global brand partnerships integrated',
          'Advanced affiliate link analytics and performance tracking',
        ],
        'features': [
          'Multi-Link Affiliate Generation',
          'Real-time Performance Analytics',
          'Commission Tracking & Withdrawal',
          'Brand Partnership Management',
          'Conversion Rate Optimization',
          'Custom Link Naming & Organization',
          'Earnings Progress Visualization',
          'Fast Payment Processing',
        ],
        'tech': [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Analytics APIs',
          'Clean Architecture'
        ],
        'icon': Icons.trending_up,
        'color': Colors.blue,
        'status': 'Live in Production',
        'metrics': '50K+ downloads • 4.2★ rating • 500+ brands',
      },
      {
        'title': 'Cha Ching - Shop & Get Cashback',
        'subtitle': 'iOS & Android • Cashback Shopping Platform',
        'description':
            'Modern cashback shopping application connecting users with retailers to earn rewards on purchases. Features merchant integration, real-time cashback tracking, and streamlined checkout experience.',
        'achievements': [
          'Built complete shopping platform with cashback system',
          'Integrated Affiliate APIs for Shopee MY'
              'Developed user-friendly shopping discovery interface',
          'Created robust backend infrastructure for transaction processing',
        ],
        'features': [
          'Merchant Discovery & Search',
          'Real-time Cashback Tracking',
          'Secure Payment Processing',
          'Transaction History & Analytics',
          'Push Notifications & Alerts',
          'User Profile & Preferences',
          'Cashback Withdrawal System',
          'Shopping Cart & Checkout Flow',
        ],
        'tech': [
          'Flutter',
          'BLoC/Cubit',
          'Firebase',
          'Payment APIs',
          'REST APIs',
          'Local Storage'
        ],
        'icon': Icons.shopping_bag,
        'color': Colors.orange,
        'status': 'Recently Launched',
        'metrics': 'New product • Finding market fit',
      },
      {
        'title': 'PocketFi - Personal Finance App',
        'subtitle': 'Personal Project • Comprehensive Finance Management',
        'description':
            'Full-featured personal finance application with expense tracking, receipt scanning, budget management, debt tracking, and collaborative wallet sharing. Built with advanced Flutter architecture patterns.',
        'achievements': [
          'Comprehensive finance management with 10+ core features',
          'Implemented receipt scanning with text highlighting technology',
          'Built collaborative wallet sharing for joint expense management',
          'Created visual savings tracking with virtual piggy bank interface',
          'Designed modular architecture with Riverpod 2.0 state management',
        ],
        'features': [
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
        'tech': [
          'Flutter',
          'Riverpod 2.0',
          'Firebase Suite',
          'OCR Technology',
          'Clean Architecture',
          'Crashlytics'
        ],
        'icon': Icons.account_balance_wallet,
        'color': Colors.green,
        'status': 'Open Source Project',
        'metrics': 'Personal project • Full feature set • GitHub available',
      },
      {
        'title': 'Flutter BLoC Starter Kit',
        'subtitle': 'Architecture Template • Production-Ready Foundation',
        'description':
            'Comprehensive Flutter starter template demonstrating clean architecture, BLoC patterns, and production-ready development practices. A showcase of how I approach building scalable Flutter applications from scratch.',
        'achievements': [
          'Designed 2-layer clean architecture for optimal balance of simplicity and scalability',
          'Implemented comprehensive dependency injection with GetIt service locator',
          'Created type-safe environment configuration with Envied package',
          'Built offline-first data persistence with Hive local storage',
          'Established robust testing framework covering all architectural layers',
        ],
        'features': [
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
        'tech': [
          'Flutter BLoC',
          'GetIt DI',
          'Retrofit & Dio',
          'Hive Storage',
          'GoRouter',
          'Envied Config',
          'Freezed Models',
          'Mocktail Testing'
        ],
        'icon': Icons.architecture,
        'color': Colors.purple,
        'status': 'Open Source Template',
        'metrics':
            'Architecture showcase • Developer template • GitHub available',
      },
    ];

    return projects.map((project) {
      return Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with icon and status
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (project['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      project['icon'] as IconData,
                      color: project['color'] as Color,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project['title'] as String,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        Text(
                          project['subtitle'] as String,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        if (project['metrics'] != null)
                          Text(
                            project['metrics'] as String,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: (project['color'] as Color).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (project['color'] as Color).withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      project['status'] as String,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: project['color'] as Color,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Description
              Text(
                project['description'] as String,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                    ),
              ),
              const SizedBox(height: 16),

              // Key achievements
              Text(
                'Key Achievements',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Column(
                children: (project['achievements'] as List<String>)
                    .take(3)
                    .map((achievement) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 16,
                          color: project['color'] as Color,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            achievement,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),

              // Show features if available
              if (project['features'] != null) ...[
                const SizedBox(height: 16),
                Text(
                  'Core Features',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: (project['features'] as List<String>)
                      .take(6)
                      .map((feature) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (project['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: (project['color'] as Color).withOpacity(0.3),
                        ),
                      ),
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    );
                  }).toList(),
                ),
              ],

              const SizedBox(height: 16),

              // Technologies
              Text(
                'Tech Stack',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: (project['tech'] as List<String>).map((tech) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: Theme.of(context)
                            .colorScheme
                            .outline
                            .withOpacity(0.2),
                      ),
                    ),
                    child: Text(
                      tech,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }

  Widget _buildFeaturesSection() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 40 : 80,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.05),
      ),
      child: Column(
        children: [
          Text(
            'Proven Track Record',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Real-world results from production applications and successful deliveries',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          if (isMobile)
            Column(
              children: _buildProvenExperienceCards(),
            )
          else
            Row(
              children: _buildProvenExperienceCards()
                  .map((card) => Expanded(child: card))
                  .toList(),
            ),
        ],
      ),
    );
  }

  List<Widget> _buildProvenExperienceCards() {
    final experiences = [
      {
        'icon': Icons.timeline,
        'title': 'Two App Launches',
        'description':
            'Successfully delivered two production mobile apps from concept to App Store/Play Store deployment',
        'evidence': 'Involve Asia (3.5 months) • Cha Ching • Both live',
        'color': Colors.blue,
      },
      {
        'icon': Icons.analytics,
        'title': 'Analytics & Monitoring',
        'description':
            'Comprehensive app analytics, user insights, and performance monitoring across production applications',
        'evidence': 'Firebase • Mixpanel • UXCam • Sentry',
        'color': Colors.green,
      },
      {
        'icon': Icons.code,
        'title': 'Clean Architecture',
        'description':
            'Implemented BLoC pattern, dependency injection, comprehensive testing in production',
        'evidence': '90%+ test coverage • CI/CD',
        'color': Colors.purple,
      },
      {
        'icon': Icons.integration_instructions,
        'title': 'Full Stack Integration',
        'description':
            'Built complete systems: mobile apps, REST APIs, admin panels, and deployment',
        'evidence': 'End-to-end delivery',
        'color': Colors.orange,
      },
    ];

    return experiences.map((experience) {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width < 768 ? 0 : 8,
          vertical: 8,
        ),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: (experience['color'] as Color).withOpacity(0.2),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: (experience['color'] as Color).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                experience['icon'] as IconData,
                size: 32,
                color: experience['color'] as Color,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              experience['title'] as String,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              experience['description'] as String,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.7),
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: (experience['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: (experience['color'] as Color).withOpacity(0.3),
                ),
              ),
              child: Text(
                experience['evidence'] as String,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: experience['color'] as Color,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildFooter() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 64,
        vertical: isMobile ? 40 : 60,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        children: [
          // Contact section
          // Container(
          //   padding: const EdgeInsets.all(32),
          //   decoration: BoxDecoration(
          //     gradient: LinearGradient(
          //       colors: [
          //         theme.colorScheme.primary.withOpacity(0.1),
          //         theme.colorScheme.secondary.withOpacity(0.05),
          //       ],
          //     ),
          //     borderRadius: BorderRadius.circular(16),
          //   ),
          //   child: Column(
          //     children: [
          //       Icon(
          //         Icons.mail_outline,
          //         size: 48,
          //         color: theme.colorScheme.primary,
          //       ),
          //       const SizedBox(height: 16),
          //       Text(
          //         'Let\'s Build Something Amazing',
          //         style: theme.textTheme.headlineSmall?.copyWith(
          //           fontWeight: FontWeight.bold,
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //       const SizedBox(height: 8),
          //       Text(
          //         'Ready to discuss your next mobile project?',
          //         style: theme.textTheme.bodyLarge?.copyWith(
          //           color: theme.colorScheme.onSurface.withOpacity(0.7),
          //         ),
          //         textAlign: TextAlign.center,
          //       ),
          //       const SizedBox(height: 24),
          //       Wrap(
          //         spacing: 16,
          //         runSpacing: 16,
          //         alignment: WrapAlignment.center,
          //         children: [
          //           ElevatedButton.icon(
          //             onPressed: () => _launchEmail(),
          //             icon: const Icon(Icons.email),
          //             label: const Text('Get In Touch'),
          //             style: ElevatedButton.styleFrom(
          //               backgroundColor: theme.colorScheme.primary,
          //               foregroundColor: theme.colorScheme.onPrimary,
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 24, vertical: 12),
          //             ),
          //           ),
          //           OutlinedButton.icon(
          //             onPressed: _launchLinkedIn,
          //             icon: const Icon(Icons.business),
          //             label: const Text('LinkedIn'),
          //             style: OutlinedButton.styleFrom(
          //               padding: const EdgeInsets.symmetric(
          //                   horizontal: 24, vertical: 12),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),

          const SizedBox(height: 32),

          // Footer links and info
          if (isMobile)
            Column(
              children: [
                _buildFooterInfo(),
                const SizedBox(height: 24),
                _buildFooterLinks(),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildFooterInfo(),
                _buildFooterLinks(),
              ],
            ),

          const SizedBox(height: 24),

          // Copyright
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '© 2025 Boon Yong Yang',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '•',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  'Built with Flutter',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterInfo() {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Boon Yong Yang',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Mobile Engineer & Flutter Expert',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.location_on,
              size: 16,
              color: theme.colorScheme.onSurface.withOpacity(0.6),
            ),
            const SizedBox(width: 4),
            Text(
              'Available for Remote Work',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFooterLinks() {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: _launchGitHub,
          icon: const Icon(Icons.code),
          tooltip: 'GitHub',
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
        IconButton(
          onPressed: _launchLinkedIn,
          icon: const Icon(Icons.business),
          tooltip: 'LinkedIn',
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
        IconButton(
          onPressed: () => _launchEmail(),
          icon: const Icon(Icons.email),
          tooltip: 'Email',
          color: theme.colorScheme.onSurface.withOpacity(0.7),
        ),
      ],
    );
  }

  void _launchEmail() async {
    final uri = Uri.parse(
        'mailto:boonyongyang@example.com?subject=Mobile Development Opportunity&body=Hi Boon Yong,%0D%0A%0D%0AI am interested in discussing a mobile development opportunity with you.%0D%0A%0D%0ABest regards,');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildSimpleTechSection(
      String title, List<Map<String, List<String>>> categories) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 20),

          // Grid layout for easy scanning
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).size.width > 768 ? 2 : 1,
              childAspectRatio:
                  MediaQuery.of(context).size.width > 768 ? 4.5 : 6,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categoryName = category.keys.first;
              final technologies = category.values.first;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: technologies.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: theme.colorScheme.outline
                                      .withOpacity(0.2),
                                ),
                              ),
                              child: Text(
                                tech,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTechTimeline() {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final techAreas = [
      {
        'title': 'Mobile Development',
        'subtitle': 'Cross-platform & Native',
        'icon': Icons.phone_android,
        'color': Colors.blue,
        'level': 'Expert',
        'technologies': [
          'Flutter & Dart',
          'BLoC/Cubit Architecture',
          'iOS & Android Deployment',
          'Material Design & Responsive UI',
          'GoRouter & Deep Linking',
          'Get_it Dependency Injection'
        ]
      },
      {
        'title': 'Development & Quality',
        'subtitle': 'Testing & Performance',
        'icon': Icons.verified,
        'color': Colors.green,
        'level': 'Advanced',
        'technologies': [
          'Unit & Widget Testing',
          'Integration Testing (Patrol)',
          'Dart DevTools Profiling',
          'API Integration (Dio & Retrofit)',
          'Local Storage (Hive)',
          'Custom Animations (Rive & Lottie)'
        ]
      },
      {
        'title': 'DevOps & Infrastructure',
        'subtitle': 'CI/CD & Cloud Services',
        'icon': Icons.cloud_queue,
        'color': Colors.orange,
        'level': 'Advanced',
        'technologies': [
          'Fastlane & Codemagic Pipelines',
          'Firebase Suite Integration',
          'Shorebird OTA Updates',
          'AWS S3 Image Storage (Recent)',
          'Supabase Integration',
          'Analytics (UXCam & Singular)',
          'Crashlytics & Error Monitoring',
          'Push Notification Services (Recent)'
        ]
      },
      {
        'title': 'Backend & Full-Stack',
        'subtitle': 'Server & Database',
        'icon': Icons.storage,
        'color': Colors.deepPurple,
        'level': 'Intermediate',
        'technologies': [
          'Laravel & Adonis.js APIs',
          'API Performance Optimization (Recent)',
          'Database Query Optimization (Recent)',
          'Redis Caching',
          'Vue.js 3 Admin Panel (Recent)',
          'TypeScript Integration',
          'Performance Monitoring'
        ]
      },
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            theme.colorScheme.surface,
            theme.colorScheme.primary.withOpacity(0.02),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            if (isMobile)
              // Mobile: Vertical timeline
              Column(
                children: techAreas.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> area = entry.value;
                  bool isLast = index == techAreas.length - 1;

                  return _buildTimelineItem(area, isLast, true, theme);
                }).toList(),
              )
            else
              // Desktop: Horizontal timeline
              Column(
                children: [
                  // Connection line
                  Container(
                    height: 4,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: techAreas
                            .map((area) => area['color'] as Color)
                            .toList(),
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Tech areas
                  Row(
                    children: techAreas.map((area) {
                      return Expanded(
                        child: _buildTimelineItem(area, false, false, theme),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem(
      Map<String, dynamic> area, bool isLast, bool isMobile, ThemeData theme) {
    return Column(
      children: [
        // Timeline node
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMobile) ...[
              // Vertical timeline
              Column(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: area['color'],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (area['color'] as Color).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      area['icon'],
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 4,
                      height: 80,
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: (area['color'] as Color).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 24),

              // Content
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: (area['color'] as Color).withOpacity(0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: _buildTimelineContent(area, theme),
                ),
              ),
            ] else ...[
              // Horizontal timeline
              Expanded(
                child: Column(
                  children: [
                    // Icon node
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: area['color'],
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (area['color'] as Color).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        area['icon'],
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Content box
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: (area['color'] as Color).withOpacity(0.2),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: _buildTimelineContent(area, theme),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineContent(Map<String, dynamic> area, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with level badge
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    area['title'],
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: area['color'],
                    ),
                  ),
                  Text(
                    area['subtitle'],
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: (area['color'] as Color).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (area['color'] as Color).withOpacity(0.3),
                ),
              ),
              child: Text(
                area['level'],
                style: theme.textTheme.bodySmall?.copyWith(
                  color: area['color'],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Technologies list
        Column(
          children: (area['technologies'] as List<String>).map((tech) {
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: area['color'],
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      tech,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
