import 'package:flutter/material.dart';

/// Custom scroll behavior with enhanced overscroll effects
class SmoothScrollBehavior extends ScrollBehavior {
  final double overscrollFriction;
  final double overscrollDampingFactor;

  /// Creates a SmoothScrollBehavior with customizable parameters
  ///
  /// [overscrollFriction] controls how "sticky" the overscroll feels (higher = more resistance)
  /// [overscrollDampingFactor] controls how quickly the overscroll bounce settles
  const SmoothScrollBehavior({
    this.overscrollFriction = 0.2,
    this.overscrollDampingFactor = 0.9,
  });

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return CustomBouncingScrollPhysics(
      parent: const AlwaysScrollableScrollPhysics(),
      customFrictionFactor: overscrollFriction,
      dampingFactor: overscrollDampingFactor,
    );
  }

  @override
  Widget buildScrollbar(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    switch (getPlatform(context)) {
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return RawScrollbar(
          controller: details.controller,
          thumbVisibility: true,
          thickness: 8,
          thumbColor: Colors.white.withOpacity(0.2),
          radius: const Radius.circular(4),
          child: child,
        );
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        return child;
    }
  }

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return StretchingOverscrollIndicator(
      axisDirection: details.direction,
      child: child,
    );
  }
}

/// Custom physics that provides more controlled bouncing when overscrolling
class CustomBouncingScrollPhysics extends BouncingScrollPhysics {
  final double customFrictionFactor;
  final double dampingFactor;

  const CustomBouncingScrollPhysics({
    super.parent,
    this.customFrictionFactor = 0.2,
    this.dampingFactor = 0.9,
  });

  @override
  CustomBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomBouncingScrollPhysics(
      parent: buildParent(ancestor),
      customFrictionFactor: customFrictionFactor,
      dampingFactor: dampingFactor,
    );
  }

  double getFrictionFactor(double overscrollFraction) => customFrictionFactor;

  @override
  SpringDescription get spring {
    // Customizing spring physics for the bounce back effect
    return SpringDescription.withDampingRatio(
      mass: 0.5,
      stiffness: 100.0,
      ratio: dampingFactor,
    );
  }
}
