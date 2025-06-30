import 'package:flutter/material.dart';
import '../widgets/sections/header_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/work_experience_section.dart';
import '../widgets/sections/production_apps_section.dart';
import '../widgets/sections/passion_projects_section.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/footer_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Fade animation for the entire page
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));

    // Slide animation for sections
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SelectionArea(
          child: SingleChildScrollView(
            controller: _scrollController,
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
                  const AnimatedSection(
                    delay: Duration(milliseconds: 0),
                    child: HeaderSection(),
                  ),
                  SlideTransition(
                    position: _slideAnimation,
                    child: const HeroSection(),
                  ),
                  const AnimatedSection(
                    delay: Duration(milliseconds: 200),
                    child: WorkExperienceSection(),
                  ),
                  const AnimatedSection(
                    delay: Duration(milliseconds: 400),
                    child: ProductionAppsSection(),
                  ),
                  const AnimatedSection(
                    delay: Duration(milliseconds: 600),
                    child: PassionProjectsSection(),
                  ),
                  const AnimatedSection(
                    delay: Duration(milliseconds: 800),
                    child: FeaturesSection(),
                  ),
                  const AnimatedSection(
                    delay: Duration(milliseconds: 1000),
                    child: FooterSection(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom widget for scroll-based animations
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.8, curve: Curves.easeOutBack),
    ));

    // Start animation after delay
    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: widget.child,
            ),
          ),
        );
      },
    );
  }
}
