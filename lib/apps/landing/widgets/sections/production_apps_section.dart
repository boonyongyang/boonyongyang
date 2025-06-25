import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utils/responsive_utils.dart';
import '../components/production_app_card.dart';
import '../../models/project_model.dart';

class ProductionAppsSection extends StatelessWidget {
  const ProductionAppsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = ResponsiveUtils.isMobile(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.getHorizontalPadding(context),
        vertical: ResponsiveUtils.getVerticalPadding(context),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(0.3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'Production Applications',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isMobile ? 24 : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(8),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 0 : 32,
                  ),
                  child: Text(
                    'Live iOS & Android apps currently serving thousands of users',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                      fontSize: isMobile ? 16 : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          const Gap(48),
          _buildProductionApps(context),
        ],
      ),
    );
  }

  Widget _buildProductionApps(BuildContext context) {
    final productionApps = ProjectModel.getProductionApps();
    final isMobile = ResponsiveUtils.isMobile(context);

    if (isMobile) {
      return Column(
        children: productionApps
            .map((app) => Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: ProductionAppCard(project: app),
                ))
            .toList(),
      );
    } else {
      return Column(
        children: productionApps.asMap().entries.map((entry) {
          final index = entry.key;
          final app = entry.value;
          final isEven = index % 2 == 0;

          return Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: ProductionAppCard(
              project: app,
              isReversed: !isEven, // Alternate layout
            ),
          );
        }).toList(),
      );
    }
  }
}
