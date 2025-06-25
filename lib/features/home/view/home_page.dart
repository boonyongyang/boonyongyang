import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

import '../../../shared/widgets/gif_carousel_widget.dart';
import '../../../shared/widgets/top_nav_bar.dart';
import '../../../shared/widgets/random_quote_widget.dart';
import '../../../shared/widgets/animated_hero_section.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../core/theme/color_palette.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait = screenSize.height > screenSize.width;

    return Scaffold(
      backgroundColor: ColorPalette.darkBackground,
      appBar: const TopNavBar(title: 'Explore'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section with DateTimer and Call-to-Action
            SizedBox(
              height: isPortrait
                  ? screenSize.height * 0.8
                  : screenSize.height * 0.9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Animated background elements
                  // First floating circle
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Positioned(
                          top: 100 +
                              30 * math.sin(_controller.value * math.pi * 2),
                          right: 100 +
                              50 * math.cos(_controller.value * math.pi * 2),
                          child: Container(
                            width: 300,
                            height: 300,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  theme.primaryColor.withOpacity(0.3),
                                  Colors.transparent,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                  // Second floating circle with different animation timing
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Positioned(
                          bottom:
                              120 + 40 * math.sin(_controller.value * math.pi),
                          left: 80 +
                              30 * math.cos(_controller.value * math.pi * 1.5),
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Colors.purple.withOpacity(0.2),
                                  Colors.transparent,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                          ),
                        );
                      }),
                  const AnimatedHeroSection(
                    badge: "Flutter Web Showcase",
                    title1: "Experience",
                    title2: "Interactive Design",
                    description:
                        "Discover a world of games, maps, and data visualization in this interactive Flutter web experience.",
                  ),
                  Positioned(
                    bottom: 80,
                    child: _buildHeroButtons(context),
                  ),
                ],
              ),
            ),

            // Features Grid with staggered animations
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  const Gap(48),
                  _buildFeaturesGrid(context),
                  const Gap(48),
                ],
              ),
            ),

            // Technology Stack Section
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildTechStackSection(context),
                  const Gap(48),
                ],
              ),
            ),

            // Performance Metrics Section
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildPerformanceSection(context),
                  const Gap(48),
                ],
              ),
            ),

            // Carousel Section with enhanced glass effect
            Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    theme.scaffoldBackgroundColor,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 16.0),
                    child: ShaderMask(
                      shaderCallback: (bounds) =>
                          ColorPalette.titleGradient.createShader(bounds),
                      child: Text(
                        'Interactive Showcases',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: isPortrait
                        ? screenSize.width * 0.6
                        : screenSize.height * 0.4,
                    child: const GifCarousel(),
                  ),
                  const Gap(48),
                ],
              ),
            ),

            // Capabilities Showcase Section
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildComparisonSection(context),
                  const Gap(48),
                ],
              ),
            ),

            // Quote Section with enhanced glass effect
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  GlassCard(
                    accentColor: theme.primaryColor,
                    child: const RandomQuoteWidget(),
                  ),
                  const Gap(48),
                ],
              ),
            ),

            // Interactive Demo Preview Section
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildInteractiveDemoSection(context),
                  const Gap(48),
                ],
              ),
            ),

            // About Section with glass effect
            Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _buildAboutSection(context, isPortrait),
                  const Gap(48),
                ],
              ),
            ),

            // Footer Section
            Container(
              color: ColorPalette.darkBackground,
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
              child: _buildFooter(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildGlowButton(
          context: context,
          onPressed: () => context.go('/plays'),
          icon: Icons.games,
          label: 'Try Games',
          color: Colors.purple,
        ),
        const Gap(16),
        _buildGlowButton(
          context: context,
          onPressed: () => context.go('/charts'),
          icon: Icons.show_chart,
          label: 'Explore Charts',
          color: Colors.blue,
        ),
      ],
    );
  }

  Widget _buildTechStackSection(BuildContext context) {
    final technologies = [
      (name: 'Flutter', icon: Icons.flutter_dash, color: Colors.blue),
      (name: 'Dart', icon: Icons.language, color: Colors.teal),
      (name: 'Firebase', icon: Icons.whatshot, color: Colors.amber),
      (name: 'Material', icon: Icons.design_services, color: Colors.red),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                'Technology Stack',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final tech in technologies)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: tech.color.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            tech.icon,
                            size: 48,
                            color: tech.color,
                          ),
                        ),
                        const Gap(8),
                        Text(
                          tech.name,
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const Gap(24),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Powered by cutting-edge technologies',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorPalette.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const Gap(16),
                  Text(
                    'This showcase is built with Flutter, leveraging the power of Dart for high-performance web applications. The Material Design system ensures a consistent and beautiful user interface, while Firebase provides backend services for data storage and authentication.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorPalette.textSecondary,
                          height: 1.5,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
    final metrics = [
      (
        title: '60+ FPS',
        description: 'Smooth animations and transitions',
        icon: Icons.speed,
        color: Colors.green
      ),
      (
        title: '< 5s',
        description: 'Initial load time',
        icon: Icons.bolt,
        color: Colors.orange
      ),
      (
        title: '98%',
        description: 'Lighthouse performance score',
        icon: Icons.insights,
        color: Colors.purple
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                'Performance Metrics',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final metric in metrics)
                  Expanded(
                    child: GlassCard(
                      accentColor: metric.color,
                      child: Column(
                        children: [
                          Icon(
                            metric.icon,
                            size: 48,
                            color: metric.color,
                          ),
                          const Gap(16),
                          Text(
                            metric.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: metric.color,
                                ),
                          ),
                          const Gap(8),
                          Text(
                            metric.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: ColorPalette.textSecondary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonSection(BuildContext context) {
    final capabilities = [
      (
        title: 'Fluid Animations',
        description:
            'Create smooth, high-performance animations that run at 60fps',
        example:
            'Animated containers, hero transitions, and physics-based scrolling',
        icon: Icons.animation,
        color: Colors.purple
      ),
      (
        title: 'Responsive Layouts',
        description: 'Build interfaces that adapt perfectly to any screen size',
        example: 'Adaptive UI components and flexible layout systems',
        icon: Icons.devices,
        color: Colors.blue
      ),
      (
        title: 'Interactive Elements',
        description: 'Engage users with interactive components and gestures',
        example: 'Drag and drop, swipe actions, and custom touch interactions',
        icon: Icons.touch_app,
        color: Colors.orange
      ),
      (
        title: 'Rich Visualization',
        description: 'Display complex data with beautiful charts and graphics',
        example: 'Custom animations, data visualization, and canvas rendering',
        icon: Icons.bar_chart,
        color: Colors.green
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                'Flutter Web Capabilities',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: capabilities.length,
              itemBuilder: (context, index) {
                final capability = capabilities[index];
                return GlassCard(
                  accentColor: capability.color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            capability.icon,
                            size: 32,
                            color: capability.color,
                          ),
                          const Gap(12),
                          Expanded(
                            child: Text(
                              capability.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: capability.color,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(12),
                      Text(
                        capability.description,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: ColorPalette.textPrimary,
                            ),
                      ),
                      const Gap(8),
                      const Divider(),
                      const Gap(8),
                      Row(
                        children: [
                          const Icon(
                            Icons.code,
                            size: 16,
                            color: Colors.white54,
                          ),
                          const Gap(8),
                          Expanded(
                            child: Text(
                              capability.example,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white70,
                                    fontStyle: FontStyle.italic,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.play_circle_outline, size: 16),
                          label: const Text('See Example'),
                          style: TextButton.styleFrom(
                            foregroundColor: capability.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Gap(32),
            Center(
              child: _buildAnimatedCapabilitiesShowcase(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedCapabilitiesShowcase(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Interactive Examples',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: ColorPalette.textPrimary,
                ),
          ),
          const Gap(16),
          Text(
            'Experience Flutter Web capabilities firsthand with these interactive examples',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ColorPalette.textSecondary,
                ),
            textAlign: TextAlign.center,
          ),
          const Gap(24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              _buildCapabilityDemoButton(
                context,
                'Drag & Drop',
                Icons.drag_indicator,
                Colors.amber,
              ),
              _buildCapabilityDemoButton(
                context,
                'Animations',
                Icons.animation,
                Colors.pink,
              ),
              _buildCapabilityDemoButton(
                context,
                'Gestures',
                Icons.touch_app,
                Colors.teal,
              ),
              _buildCapabilityDemoButton(
                context,
                'Transitions',
                Icons.flip,
                Colors.indigo,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCapabilityDemoButton(
      BuildContext context, String label, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.2),
        foregroundColor: color,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _buildInteractiveDemoSection(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                'Try It Yourself',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(24),
            GlassCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Demo Preview Container
                  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.deepPurple.withOpacity(0.7),
                          Colors.blue.withOpacity(0.7),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.touch_app,
                            size: 48,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          const Gap(16),
                          Text(
                            'Interactive Demo',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          const Gap(8),
                          Text(
                            'Click to play with our sample application',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.9),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildDemoFeatureItem(
                        context,
                        Icons.drag_indicator,
                        'Drag & Drop',
                      ),
                      _buildDemoFeatureItem(
                        context,
                        Icons.animation,
                        'Animations',
                      ),
                      _buildDemoFeatureItem(
                        context,
                        Icons.touch_app,
                        'Interactive',
                      ),
                      _buildDemoFeatureItem(
                        context,
                        Icons.mobile_friendly,
                        'Responsive',
                      ),
                    ],
                  ),
                  const Gap(24),
                  _buildGlowButton(
                    context: context,
                    onPressed: () {},
                    icon: Icons.play_arrow,
                    label: 'Launch Interactive Demo',
                    color: Colors.deepPurple,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoFeatureItem(
      BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white70,
        ),
        const Gap(8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white70,
              ),
        ),
      ],
    );
  }

  Widget _buildFeaturesGrid(BuildContext context) {
    final features = [
      (
        title: 'Games & Fun',
        description: 'Challenge yourself with interactive games',
        icon: Icons.games,
        color: Colors.purple,
        path: '/plays'
      ),
      (
        title: 'Data Visualization',
        description: 'Beautiful charts and graphs for data analysis',
        icon: Icons.show_chart,
        color: Colors.green,
        path: '/charts'
      ),
      (
        title: 'Interactive Maps',
        description: 'Explore locations with our interactive mapping system',
        icon: Icons.map,
        color: Colors.blue,
        path: '/maps'
      ),
      (
        title: 'Experimental Lab',
        description: 'Try out our latest experimental features',
        icon: Icons.science,
        color: Colors.orange,
        path: '/labs'
      ),
    ];

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) =>
                  ColorPalette.titleGradient.createShader(bounds),
              child: Text(
                'Explore Features',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const Gap(24),
            Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: [
                for (var i = 0; i < features.length; i++)
                  GlassCard(
                    delay: Duration(milliseconds: 200 * i),
                    accentColor: features[i].color,
                    onTap: () => context.go(features[i].path),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -15,
                          bottom: -15,
                          child: Icon(
                            features[i].icon,
                            size: 100,
                            color: features[i].color.withOpacity(0.1),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              features[i].icon,
                              size: 48,
                              color: features[i].color,
                            ),
                            const Gap(16),
                            Text(
                              features[i].title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: ColorPalette.textPrimary,
                                  ),
                            ),
                            const Gap(8),
                            SizedBox(
                              width: 280,
                              child: Text(
                                features[i].description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: ColorPalette.textSecondary,
                                    ),
                              ),
                            ),
                            const Gap(16),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward,
                                color: features[i].color,
                              ),
                            ),
                          ],
                        ),
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

  Widget _buildAboutSection(BuildContext context, bool isPortrait) {
    return Center(
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) =>
                ColorPalette.titleGradient.createShader(bounds),
            child: Text(
              'About the Project',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const Gap(16),
          GlassCard(
            padding: const EdgeInsets.all(32),
            child: SizedBox(
              width: isPortrait ? double.infinity : 600,
              child: Column(
                children: [
                  Text(
                    'A showcase of interactive Flutter web capabilities',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorPalette.textPrimary,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(16),
                  Text(
                    'This project demonstrates the power of Flutter for web applications, featuring interactive maps, data visualization, experimental features, and engaging games. Explore different sections to experience the full capabilities of modern web development with Flutter.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorPalette.textSecondary,
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const Gap(24),
                  _buildGlowButton(
                    context: context,
                    onPressed: () => context.go('/about'),
                    icon: Icons.info_outline,
                    label: 'Learn More',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.code, color: Colors.white70),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.analytics, color: Colors.white70),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.web, color: Colors.white70),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white70),
                onPressed: () {},
              ),
            ],
          ),
          const Gap(16),
          const Text(
            '© 2025 Flutter Showcase — Built with Flutter for Web',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text('Privacy',
                    style: TextStyle(color: Colors.white70)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Terms',
                    style: TextStyle(color: Colors.white70)),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('Contact',
                    style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlowButton({
    required BuildContext context,
    required VoidCallback onPressed,
    required IconData icon,
    required String label,
    Color? color,
  }) {
    final buttonColor = color ?? Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            buttonColor,
            buttonColor.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: buttonColor.withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: -2,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
