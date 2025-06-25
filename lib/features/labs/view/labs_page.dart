import 'package:boonyongyang/shared/widgets/top_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'fruits_page.dart';
import 'theme_showcase_page.dart';

class LabsPage extends StatelessWidget {
  const LabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(title: 'Labs'),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _ExperimentCard(
            title: 'Theme Showcase',
            description: 'Fantasy-inspired dark theme',
            icon: Icons.auto_awesome,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeShowcasePage(),
                ),
              );
            },
          ),
          _ExperimentCard(
            title: 'Fruits',
            description: 'Fruit list with details',
            icon: Icons.science,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FruitsPage(),
                ),
              );
            },
          ),
          _ExperimentCard(
            title: 'Experiment 2',
            description: 'UI Prototypes',
            icon: Icons.design_services,
            onTap: () {
              // TODO: Implement experiment 2
            },
          ),
        ],
      ),
    );
  }
}

class _ExperimentCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  const _ExperimentCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      // shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const Gap(8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
