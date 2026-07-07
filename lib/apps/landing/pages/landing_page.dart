import 'package:flutter/material.dart';

import '../theme/landing_theme.dart';
import '../widgets/components/landing_design_system.dart';
import '../widgets/sections/features_section.dart';
import '../widgets/sections/footer_section.dart';
import '../widgets/sections/header_section.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/passion_projects_section.dart';
import '../widgets/sections/production_apps_section.dart';
import '../widgets/sections/work_experience_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({
    super.key,
    required this.activePreset,
    required this.onThemeChanged,
  });

  final LandingThemePreset activePreset;
  final ValueChanged<LandingThemePreset> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;

    return Scaffold(
      backgroundColor: tokens.background,
      body: SelectionArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              HeaderSection(
                activePreset: activePreset,
                onThemeChanged: onThemeChanged,
              ),
              const HeroSection(),
              WorkExperienceSection(background: tokens.surface),
              const ProductionAppsSection(),
              PassionProjectsSection(background: tokens.surface),
              const FeaturesSection(),
              FooterSection(background: tokens.surface),
            ],
          ),
        ),
      ),
    );
  }
}
