import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

enum PortfolioSurface {
  flutterPortfolio,
  flutterInteractive,
  nextThree,
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
          defaultValue: 'https://boonyongyang-app.web.app',
        );
      case PortfolioSurface.nextThree:
        return const String.fromEnvironment(
          'PORTFOLIO_3D_URL',
          defaultValue: 'https://boonyongyang-3d.web.app',
        );
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

  Future<void> _openSurface(PortfolioSurface surface) async {
    await launchUrl(
      Uri.parse(surface.url),
      webOnlyWindowName: '_self',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = foregroundColor ?? theme.colorScheme.onSurface;

    return PopupMenuButton<PortfolioSurface>(
      tooltip: 'Portfolio versions',
      onSelected: _openSurface,
      itemBuilder: (context) {
        return PortfolioSurface.values.map((surface) {
          final isCurrent = surface == currentSurface;

          return PopupMenuItem<PortfolioSurface>(
            value: surface,
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
        }).toList();
      },
      child: Semantics(
        button: true,
        label: 'Portfolio versions. Current: ${currentSurface.label}',
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
