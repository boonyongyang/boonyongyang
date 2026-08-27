import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/portfolio_analytics.dart';

enum PortfolioSurface {
  flutterPortfolio,
  flutterInteractive,
  nextThree,
  releaseDossier,
}

enum PortfolioThreeTheme {
  releaseBench,
  fieldManual,
  reviewRoom,
}

extension PortfolioSurfaceDetails on PortfolioSurface {
  String get label {
    switch (this) {
      case PortfolioSurface.flutterPortfolio:
        return 'Flutter portfolio';
      case PortfolioSurface.flutterInteractive:
        return 'Flutter interactive app';
      case PortfolioSurface.nextThree:
        return 'Next.js + Three.js portfolio';
      case PortfolioSurface.releaseDossier:
        return 'V4 Release Dossier';
    }
  }

  String get url {
    switch (this) {
      case PortfolioSurface.flutterPortfolio:
        return const String.fromEnvironment(
          'SITE_URL',
          defaultValue: 'https://boonyongyang.com',
        );
      case PortfolioSurface.flutterInteractive:
        return const String.fromEnvironment(
          'APP_URL',
          defaultValue: 'https://app.boonyongyang.com',
        );
      case PortfolioSurface.nextThree:
        return const String.fromEnvironment(
          'PORTFOLIO_3D_URL',
          defaultValue: 'https://3d.boonyongyang.com',
        );
      case PortfolioSurface.releaseDossier:
        return const String.fromEnvironment(
          'PORTFOLIO_V4_URL',
          defaultValue: 'https://boonyongyang-v4.web.app',
        );
    }
  }
}

extension PortfolioThreeThemeDetails on PortfolioThreeTheme {
  String get label {
    switch (this) {
      case PortfolioThreeTheme.releaseBench:
        return 'Release Bench';
      case PortfolioThreeTheme.fieldManual:
        return 'Field Manual';
      case PortfolioThreeTheme.reviewRoom:
        return 'Store Review Room';
    }
  }

  String get url {
    final baseUrl = PortfolioSurface.nextThree.url;
    switch (this) {
      case PortfolioThreeTheme.releaseBench:
        return '$baseUrl/themes/release-bench/';
      case PortfolioThreeTheme.fieldManual:
        return '$baseUrl/themes/field-manual/';
      case PortfolioThreeTheme.reviewRoom:
        return '$baseUrl/themes/review-room/';
    }
  }
}

class PortfolioVersionMenu extends StatelessWidget {
  const PortfolioVersionMenu({
    super.key,
    required this.currentSurface,
    this.compact = false,
    this.foregroundColor,
    this.borderColor,
    this.backgroundColor,
  });

  final PortfolioSurface currentSurface;
  final bool compact;
  final Color? foregroundColor;
  final Color? borderColor;
  final Color? backgroundColor;

  Future<void> _openDestination(Uri destination) async {
    PortfolioAnalytics.trackDestination(destination);
    await launchUrl(
      destination,
      webOnlyWindowName: '_self',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = foregroundColor ?? theme.colorScheme.onSurface;

    return PopupMenuButton<Uri>(
      tooltip: 'Portfolio versions and 3D themes',
      onSelected: _openDestination,
      itemBuilder: (context) {
        final versionItems = PortfolioSurface.values.map((surface) {
          final isCurrent = surface == currentSurface;

          return PopupMenuItem<Uri>(
            value: Uri.parse(surface.url),
            enabled: !isCurrent,
            child: Row(
              children: [
                if (isCurrent)
                  Icon(Icons.check, size: 18, color: theme.colorScheme.primary)
                else
                  const SizedBox(width: 18),
                const Gap(12),
                Expanded(child: Text(surface.label)),
                if (isCurrent) ...[
                  const Gap(12),
                  Text('Current', style: theme.textTheme.labelSmall),
                ],
              ],
            ),
          );
        });

        final themeItems = PortfolioThreeTheme.values.map((themePreset) {
          return PopupMenuItem<Uri>(
            value: Uri.parse(themePreset.url),
            child: Row(
              children: [
                const SizedBox(width: 18),
                const Gap(12),
                Expanded(child: Text(themePreset.label)),
              ],
            ),
          );
        });

        return [
          PopupMenuItem<Uri>(
            enabled: false,
            height: 32,
            child: Text(
              'Portfolio versions',
              style: theme.textTheme.labelSmall,
            ),
          ),
          ...versionItems,
          const PopupMenuDivider(),
          PopupMenuItem<Uri>(
            enabled: false,
            height: 32,
            child: Text(
              '3D themes',
              style: theme.textTheme.labelSmall,
            ),
          ),
          ...themeItems,
        ];
      },
      child: Semantics(
        button: true,
        label:
            'Portfolio versions and 3D themes. Current: ${currentSurface.label}',
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border:
                borderColor == null ? null : Border.all(color: borderColor!),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.layers_outlined, size: 18, color: color),
                if (!compact) ...[
                  const Gap(8),
                  Text(
                    'Versions',
                    style: theme.textTheme.labelMedium?.copyWith(color: color),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
