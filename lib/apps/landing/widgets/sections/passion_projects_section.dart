import 'package:flutter/material.dart';

import '../../models/project_model.dart';
import '../components/landing_design_system.dart';
import '../components/project_card.dart';

class PassionProjectsSection extends StatelessWidget {
  const PassionProjectsSection({
    super.key,
    this.background,
  });

  final Color? background;

  @override
  Widget build(BuildContext context) {
    final projects = ProjectModel.getPersonalProjects();

    return LandingSection(
      eyebrow: 'Project Index',
      title: 'Personal projects, kept compact.',
      body:
          'A scan-friendly index of architecture references and app experiments without the oversized showcase treatment.',
      background: background,
      child: Column(
        children: [
          for (final project in projects) ProjectCard(project: project),
        ],
      ),
    );
  }
}
