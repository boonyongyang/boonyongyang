import 'package:flutter/material.dart';

class AppColors {
  // Main colors
  static const Color neonBlue = Color(0xFF3A7BEF); // Brighter blue
  static const Color cyberpunkPurple = Color(0xFF8A49D8); // Less dark purple
  static const Color midnightBlue = Color(0xFF1E3252); // Softer dark blue
  static const Color techNavy = Color(0xFF1E2740); // Less dark navy
  static const Color nightShade =
      Color(0xFF202438); // Slightly lighter background

  // Accent colors
  static const Color neonAqua = Color(0xFF05D9E8); // Bright teal for highlights
  static const Color syntheticIndigo = Color(0xFF7C7FF9); // Softer indigo
  static const Color cyborgPurple = Color(0xFFAB65FF); // Brighter purple
  static const Color digitalTeal = Color(0xFF3DDBD9); // Bright teal
  static const Color laserAmber = Color(0xFFFFB52E); // Warmer amber

  // Text colors
  static const Color hologramWhite =
      Color(0xFFEBF0FF); // Slightly blue-tinted white
  static const Color matrixSilver = Color(0xFFCED5E5); // Metallic silver
  static const Color ghostBlue = Color(0xFFB0C2DE); // Soft blue text

  // Status colors
  static const Color successGreen = Color(0xFF4EFFA4); // Brighter green
  static const Color errorRed = Color(0xFFFF5E7C); // Softer red
  static const Color infoBlue = Color(0xFF56CCFF); // Brighter blue
  static const Color warningYellow = Color(0xFFFFC857); // Softer yellow
}

class AppGradients {
  static const LinearGradient cyberHorizon = LinearGradient(
    colors: [AppColors.nightShade, AppColors.techNavy],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient neuroPortal = LinearGradient(
    colors: [AppColors.cyberpunkPurple, AppColors.midnightBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient synthwaveEnergy = LinearGradient(
    colors: [AppColors.syntheticIndigo, AppColors.cyborgPurple],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient neonDream = LinearGradient(
    colors: [AppColors.neonBlue, AppColors.neonAqua],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}

class AppShadows {
  static List<BoxShadow> subtle = [
    BoxShadow(
      color: AppColors.nightShade.withOpacity(0.3),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> neonGlow = [
    BoxShadow(
      color: AppColors.neonAqua.withOpacity(0.3),
      blurRadius: 8,
      spreadRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];

  static List<BoxShadow> purpleGlow = [
    BoxShadow(
      color: AppColors.cyborgPurple.withOpacity(0.4),
      blurRadius: 10,
      spreadRadius: 1,
      offset: const Offset(0, 3),
    ),
  ];
}

class AppBorders {
  static BorderRadius roundedSmall = BorderRadius.circular(8);
  static BorderRadius roundedMedium = BorderRadius.circular(16);
  static BorderRadius roundedLarge = BorderRadius.circular(24);
  static BorderRadius angledBorder = const BorderRadius.only(
    topLeft: Radius.circular(4),
    topRight: Radius.circular(16),
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(4),
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
}
