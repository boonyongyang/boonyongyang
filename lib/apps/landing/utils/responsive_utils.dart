import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 768 && width < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getHorizontalPadding(BuildContext context) {
    return isMobile(context) ? 24.0 : 64.0;
  }

  static double getVerticalPadding(BuildContext context) {
    return isMobile(context) ? 40.0 : 80.0;
  }

  static double getMaxContentWidth(BuildContext context) {
    return isMobile(context) ? double.infinity : 600.0;
  }

  static int getCrossAxisCount(BuildContext context) {
    if (isMobile(context)) return 1;
    if (isTablet(context)) return 2;
    return 3;
  }
}
