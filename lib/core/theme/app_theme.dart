import 'package:flutter/material.dart';
import '../style/style.dart';

/// App theme configuration with cyberpunk-inspired dark theme
class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.neonBlue,
    scaffoldBackgroundColor: AppColors.nightShade,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.neonBlue,
      onPrimary: AppColors.hologramWhite,
      secondary: AppColors.cyborgPurple,
      onSecondary: AppColors.hologramWhite,
      error: AppColors.errorRed,
      onError: AppColors.hologramWhite,
      surface: AppColors.techNavy,
      onSurface: AppColors.hologramWhite,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.hologramWhite),
      displayMedium: TextStyle(color: AppColors.hologramWhite),
      displaySmall: TextStyle(color: AppColors.hologramWhite),
      headlineLarge: TextStyle(color: AppColors.hologramWhite),
      headlineMedium: TextStyle(color: AppColors.hologramWhite),
      headlineSmall: TextStyle(color: AppColors.hologramWhite),
      titleLarge: TextStyle(color: AppColors.hologramWhite),
      titleMedium: TextStyle(color: AppColors.hologramWhite),
      titleSmall: TextStyle(color: AppColors.hologramWhite, letterSpacing: 0.5),
      bodyLarge: TextStyle(color: AppColors.matrixSilver),
      bodyMedium: TextStyle(color: AppColors.matrixSilver),
      bodySmall: TextStyle(color: AppColors.ghostBlue),
      labelLarge: TextStyle(color: AppColors.hologramWhite),
      labelMedium: TextStyle(color: AppColors.hologramWhite),
      labelSmall: TextStyle(color: AppColors.ghostBlue),
    ),
    cardTheme: CardTheme(
      color: AppColors.techNavy,
      elevation: 4,
      margin: const EdgeInsets.all(AppSpacing.sm),
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.roundedMedium,
        side: BorderSide(
            color: AppColors.syntheticIndigo.withOpacity(0.2), width: 1),
      ),
      shadowColor: AppColors.cyborgPurple.withOpacity(0.3),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.techNavy,
      foregroundColor: AppColors.hologramWhite,
      shadowColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.hologramWhite,
        backgroundColor: AppColors.neonBlue,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textStyle: const TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.roundedSmall,
        ),
        elevation: 4,
        shadowColor: AppColors.neonBlue.withOpacity(0.5),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.neonAqua,
        side: const BorderSide(color: AppColors.neonAqua, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: AppBorders.roundedSmall,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.digitalTeal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.midnightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: AppColors.syntheticIndigo.withOpacity(0.5),
          width: 1,
        ),
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.matrixSilver,
      size: 24,
    ),
    dividerTheme: DividerThemeData(
      color: AppColors.syntheticIndigo.withOpacity(0.3),
      thickness: 1,
      space: 24,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.techNavy,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.roundedMedium,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.midnightBlue,
      contentTextStyle: const TextStyle(color: AppColors.hologramWhite),
      shape: RoundedRectangleBorder(
        borderRadius: AppBorders.roundedSmall,
      ),
      behavior: SnackBarBehavior.floating,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.techNavy,
      selectedItemColor: AppColors.neonAqua,
      unselectedItemColor: AppColors.matrixSilver.withOpacity(0.5),
      type: BottomNavigationBarType.fixed,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.techNavy,
      border: OutlineInputBorder(
        borderRadius: AppBorders.roundedSmall,
        borderSide: BorderSide(color: AppColors.cyborgPurple.withOpacity(0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppBorders.roundedSmall,
        borderSide:
            BorderSide(color: AppColors.syntheticIndigo.withOpacity(0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppBorders.roundedSmall,
        borderSide: const BorderSide(color: AppColors.neonAqua),
      ),
    ),
    // Add progressive border glow effect on hover for interactive elements
    hoverColor: AppColors.neonAqua.withOpacity(0.05),
    splashColor: AppColors.neonAqua.withOpacity(0.1),
    highlightColor: AppColors.cyborgPurple.withOpacity(0.1),
  );
}
