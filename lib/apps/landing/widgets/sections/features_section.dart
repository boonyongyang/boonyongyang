import 'package:flutter/material.dart';

import '../components/landing_design_system.dart';
import '../components/technical_skill_section.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const LandingSection(
      eyebrow: 'Capabilities',
      title: 'A focused Flutter stack, not a wall of badges.',
      body:
          'Grouped by how the work gets shipped: product UI, architecture, integrations, release systems, and the surrounding tools.',
      child: TechnicalSkillSection(),
    );
  }
}
