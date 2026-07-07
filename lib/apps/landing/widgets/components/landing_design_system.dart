import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/landing_theme.dart';
import '../../utils/responsive_utils.dart';

extension LandingContextX on BuildContext {
  LandingTokens get landingTokens {
    return Theme.of(this).extension<LandingTokens>()!;
  }

  bool get isLandingMobile => ResponsiveUtils.isMobile(this);
}

class LandingSection extends StatelessWidget {
  const LandingSection({
    super.key,
    required this.title,
    required this.child,
    this.eyebrow,
    this.body,
    this.background,
    this.tight = false,
  });

  final String? eyebrow;
  final String title;
  final String? body;
  final Widget child;
  final Color? background;
  final bool tight;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    final isMobile = context.isLandingMobile;

    return DecoratedBox(
      decoration: BoxDecoration(color: background ?? tokens.background),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.getHorizontalPadding(context),
          vertical: tight
              ? (isMobile ? tokens.spaceXl : 56)
              : (isMobile ? 56 : tokens.space2xl),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: tokens.maxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eyebrow != null) ...[
                  Text(
                    eyebrow!,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: tokens.accent,
                    ),
                  ),
                  Gap(tokens.spaceSm),
                ],
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 760),
                  child: Text(
                    title,
                    style: isMobile
                        ? theme.textTheme.headlineMedium
                        : theme.textTheme.headlineLarge,
                  ),
                ),
                if (body != null) ...[
                  Gap(tokens.spaceMd),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 680),
                    child: Text(
                      body!,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ],
                Gap(isMobile ? tokens.spaceXl : 56),
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LandingPanel extends StatelessWidget {
  const LandingPanel({
    super.key,
    required this.child,
    this.padding,
    this.background,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: background ?? tokens.surface,
        borderRadius: BorderRadius.circular(tokens.radiusMd),
        border: Border.all(color: tokens.border),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(context.isLandingMobile ? 20 : 28),
        child: child,
      ),
    );
  }
}

class LandingButton extends StatelessWidget {
  const LandingButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.primary = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final child = icon == null
        ? Text(label)
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17),
              const Gap(8),
              Text(label),
            ],
          );

    if (primary) {
      return ElevatedButton(onPressed: onPressed, child: child);
    }
    return OutlinedButton(onPressed: onPressed, child: child);
  }
}

class LandingBadge extends StatelessWidget {
  const LandingBadge({
    super.key,
    required this.label,
    this.emphasis = false,
  });

  final String label;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasis ? tokens.accentSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(tokens.radiusXs),
        border: Border.all(
          color: emphasis ? tokens.accent.withOpacity(0.35) : tokens.border,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        child: Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: emphasis ? tokens.accent : tokens.textMuted,
          ),
        ),
      ),
    );
  }
}

class LandingMetricRow extends StatelessWidget {
  const LandingMetricRow({
    super.key,
    required this.items,
  });

  final List<LandingMetricItem> items;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final isMobile = context.isLandingMobile;

    if (isMobile) {
      return Column(
        children: [
          for (final item in items) ...[
            item,
            if (item != items.last)
              Divider(height: tokens.spaceLg, color: tokens.border),
          ],
        ],
      );
    }

    return Row(
      children: [
        for (final item in items) ...[
          Expanded(child: item),
          if (item != items.last)
            Container(
              height: 44,
              width: 1,
              margin: EdgeInsets.symmetric(horizontal: tokens.spaceLg),
              color: tokens.border,
            ),
        ],
      ],
    );
  }
}

class LandingMetricItem extends StatelessWidget {
  const LandingMetricItem({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: tokens.text,
          ),
        ),
        Gap(tokens.spaceXs),
        Text(label, style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class LandingList extends StatelessWidget {
  const LandingList({
    super.key,
    required this.items,
    this.maxItems,
  });

  final List<String> items;
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final tokens = context.landingTokens;
    final visibleItems =
        maxItems == null ? items : items.take(maxItems!).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in visibleItems) ...[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(top: 9),
                decoration: BoxDecoration(
                  color: tokens.accent,
                  shape: BoxShape.circle,
                ),
              ),
              Gap(tokens.spaceSm),
              Expanded(
                child: Text(
                  item,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          if (item != visibleItems.last) Gap(tokens.spaceSm),
        ],
      ],
    );
  }
}
