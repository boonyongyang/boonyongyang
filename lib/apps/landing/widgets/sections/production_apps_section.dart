import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../models/project_model.dart';
import '../components/landing_design_system.dart';
import '../components/production_app_card.dart';

class ProductionAppsSection extends StatelessWidget {
  const ProductionAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final productionApps = ProjectModel.getProductionApps();

    return LandingSection(
      eyebrow: 'Selected Work',
      title: 'Production apps with real release pressure.',
      body:
          'A tighter view of shipped mobile products: the role, the product work, and the operational result.',
      child: Column(
        children: [
          for (var index = 0; index < productionApps.length; index++) ...[
            ProductionAppCard(
              project: productionApps[index],
              isReversed: index.isOdd,
            ),
            if (index != productionApps.length - 1) Gap(tokens.spaceLg),
          ],
        ],
      ),
    );
  }
}
