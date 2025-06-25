import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 900;
  static const double desktopBreakpoint = 1200;
  static const double largeDesktopBreakpoint = 1600;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= desktopBreakpoint;
  }

  static bool isLargeDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeDesktopBreakpoint;
  }

  static bool isSmallMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 400;
  }

  static double getHorizontalPadding(BuildContext context) {
    if (isSmallMobile(context)) return 16.0;
    if (isMobile(context)) return 24.0;
    if (isTablet(context)) return 48.0;
    if (isLargeDesktop(context)) return 120.0;
    return 80.0;
  }

  static double getVerticalPadding(BuildContext context) {
    if (isSmallMobile(context)) return 24.0;
    if (isMobile(context)) return 40.0;
    if (isTablet(context)) return 60.0;
    return 80.0;
  }

  static double getMaxContentWidth(BuildContext context) {
    if (isMobile(context)) return double.infinity;
    if (isTablet(context)) return 800.0;
    return double.infinity; // Allow full width on desktop
  }

  static int getCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }

  static double getFontScale(BuildContext context) {
    if (isSmallMobile(context)) return 0.85;
    if (isMobile(context)) return 0.9;
    return 1.0;
  }

  static double getButtonPadding(BuildContext context) {
    if (isMobile(context)) return 12.0;
    return 16.0;
  }

  static double getIconSize(BuildContext context) {
    if (isSmallMobile(context)) return 20.0;
    if (isMobile(context)) return 24.0;
    return 28.0;
  }

  static EdgeInsets getContentPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: getHorizontalPadding(context),
      vertical: getVerticalPadding(context),
    );
  }

  static double getSpacing(BuildContext context, {double? mobile, double? tablet, double? desktop}) {
    if (isMobile(context)) return mobile ?? 16.0;
    if (isTablet(context)) return tablet ?? 24.0;
    return desktop ?? 32.0;
  }
}
