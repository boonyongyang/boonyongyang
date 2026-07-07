import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

enum LandingThemePreset {
  studioLight,
  midnightZinc,
  signalAmber,
}

extension LandingThemePresetX on LandingThemePreset {
  String get label {
    switch (this) {
      case LandingThemePreset.studioLight:
        return 'Studio Light';
      case LandingThemePreset.midnightZinc:
        return 'Midnight Zinc';
      case LandingThemePreset.signalAmber:
        return 'Signal Amber';
    }
  }

  String get shortLabel {
    switch (this) {
      case LandingThemePreset.studioLight:
        return 'Light';
      case LandingThemePreset.midnightZinc:
        return 'Zinc';
      case LandingThemePreset.signalAmber:
        return 'Amber';
    }
  }
}

class LandingTokens extends ThemeExtension<LandingTokens> {
  const LandingTokens({
    required this.background,
    required this.surface,
    required this.elevated,
    required this.border,
    required this.muted,
    required this.text,
    required this.textMuted,
    required this.accent,
    required this.accentSoft,
    required this.success,
    required this.warning,
    required this.maxWidth,
    required this.radiusXs,
    required this.radiusSm,
    required this.radiusMd,
    required this.spaceXs,
    required this.spaceSm,
    required this.spaceMd,
    required this.spaceLg,
    required this.spaceXl,
    required this.space2xl,
  });

  final Color background;
  final Color surface;
  final Color elevated;
  final Color border;
  final Color muted;
  final Color text;
  final Color textMuted;
  final Color accent;
  final Color accentSoft;
  final Color success;
  final Color warning;

  final double maxWidth;
  final double radiusXs;
  final double radiusSm;
  final double radiusMd;
  final double spaceXs;
  final double spaceSm;
  final double spaceMd;
  final double spaceLg;
  final double spaceXl;
  final double space2xl;

  @override
  LandingTokens copyWith({
    Color? background,
    Color? surface,
    Color? elevated,
    Color? border,
    Color? muted,
    Color? text,
    Color? textMuted,
    Color? accent,
    Color? accentSoft,
    Color? success,
    Color? warning,
    double? maxWidth,
    double? radiusXs,
    double? radiusSm,
    double? radiusMd,
    double? spaceXs,
    double? spaceSm,
    double? spaceMd,
    double? spaceLg,
    double? spaceXl,
    double? space2xl,
  }) {
    return LandingTokens(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      elevated: elevated ?? this.elevated,
      border: border ?? this.border,
      muted: muted ?? this.muted,
      text: text ?? this.text,
      textMuted: textMuted ?? this.textMuted,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      maxWidth: maxWidth ?? this.maxWidth,
      radiusXs: radiusXs ?? this.radiusXs,
      radiusSm: radiusSm ?? this.radiusSm,
      radiusMd: radiusMd ?? this.radiusMd,
      spaceXs: spaceXs ?? this.spaceXs,
      spaceSm: spaceSm ?? this.spaceSm,
      spaceMd: spaceMd ?? this.spaceMd,
      spaceLg: spaceLg ?? this.spaceLg,
      spaceXl: spaceXl ?? this.spaceXl,
      space2xl: space2xl ?? this.space2xl,
    );
  }

  @override
  LandingTokens lerp(ThemeExtension<LandingTokens>? other, double t) {
    if (other is! LandingTokens) return this;
    return LandingTokens(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      elevated: Color.lerp(elevated, other.elevated, t)!,
      border: Color.lerp(border, other.border, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      text: Color.lerp(text, other.text, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      maxWidth: lerpDouble(maxWidth, other.maxWidth, t)!,
      radiusXs: lerpDouble(radiusXs, other.radiusXs, t)!,
      radiusSm: lerpDouble(radiusSm, other.radiusSm, t)!,
      radiusMd: lerpDouble(radiusMd, other.radiusMd, t)!,
      spaceXs: lerpDouble(spaceXs, other.spaceXs, t)!,
      spaceSm: lerpDouble(spaceSm, other.spaceSm, t)!,
      spaceMd: lerpDouble(spaceMd, other.spaceMd, t)!,
      spaceLg: lerpDouble(spaceLg, other.spaceLg, t)!,
      spaceXl: lerpDouble(spaceXl, other.spaceXl, t)!,
      space2xl: lerpDouble(space2xl, other.space2xl, t)!,
    );
  }
}

class LandingTheme {
  static ThemeData get lightTheme => themeFor(LandingThemePreset.studioLight);
  static ThemeData get darkTheme => themeFor(LandingThemePreset.midnightZinc);

  static ThemeData themeFor(LandingThemePreset preset) {
    switch (preset) {
      case LandingThemePreset.studioLight:
        return _buildTheme(
          brightness: Brightness.light,
          tokens: const LandingTokens(
            background: Color(0xFFFAFAF8),
            surface: Color(0xFFFFFFFF),
            elevated: Color(0xFFF0F0ED),
            border: Color(0xFFDADAD4),
            muted: Color(0xFF71717A),
            text: Color(0xFF18181B),
            textMuted: Color(0xFF5F5F67),
            accent: Color(0xFF2563EB),
            accentSoft: Color(0xFFEAF1FF),
            success: Color(0xFF15803D),
            warning: Color(0xFFB45309),
            maxWidth: 1180,
            radiusXs: 4,
            radiusSm: 6,
            radiusMd: 8,
            spaceXs: 6,
            spaceSm: 10,
            spaceMd: 16,
            spaceLg: 24,
            spaceXl: 40,
            space2xl: 72,
          ),
        );
      case LandingThemePreset.midnightZinc:
        return _buildTheme(
          brightness: Brightness.dark,
          tokens: const LandingTokens(
            background: Color(0xFF09090B),
            surface: Color(0xFF111113),
            elevated: Color(0xFF18181B),
            border: Color(0xFF2A2A2E),
            muted: Color(0xFFA1A1AA),
            text: Color(0xFFF4F4F5),
            textMuted: Color(0xFFA1A1AA),
            accent: Color(0xFF22D3EE),
            accentSoft: Color(0xFF11343A),
            success: Color(0xFF4ADE80),
            warning: Color(0xFFFBBF24),
            maxWidth: 1180,
            radiusXs: 4,
            radiusSm: 6,
            radiusMd: 8,
            spaceXs: 6,
            spaceSm: 10,
            spaceMd: 16,
            spaceLg: 24,
            spaceXl: 40,
            space2xl: 72,
          ),
        );
      case LandingThemePreset.signalAmber:
        return _buildTheme(
          brightness: Brightness.dark,
          tokens: const LandingTokens(
            background: Color(0xFF0F0F0E),
            surface: Color(0xFF171716),
            elevated: Color(0xFF20201D),
            border: Color(0xFF34342F),
            muted: Color(0xFFB8B3A7),
            text: Color(0xFFF7F4ED),
            textMuted: Color(0xFFB8B3A7),
            accent: Color(0xFFF59E0B),
            accentSoft: Color(0xFF3A2A12),
            success: Color(0xFF86EFAC),
            warning: Color(0xFFFACC15),
            maxWidth: 1180,
            radiusXs: 4,
            radiusSm: 6,
            radiusMd: 8,
            spaceXs: 6,
            spaceSm: 10,
            spaceMd: 16,
            spaceLg: 24,
            spaceXl: 40,
            space2xl: 72,
          ),
        );
    }
  }

  static ThemeData _buildTheme({
    required Brightness brightness,
    required LandingTokens tokens,
  }) {
    final colorScheme = ColorScheme(
      brightness: brightness,
      primary: tokens.accent,
      onPrimary:
          brightness == Brightness.dark ? tokens.background : Colors.white,
      secondary: tokens.muted,
      onSecondary: tokens.background,
      error: const Color(0xFFDC2626),
      onError: Colors.white,
      surface: tokens.surface,
      onSurface: tokens.text,
    );

    final textTheme = _textTheme(tokens);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: tokens.background,
      fontFamily: 'Inter',
      fontFamilyFallback: const [
        'SF Pro Text',
        'Segoe UI',
        'Roboto',
        'Helvetica Neue',
        'Arial',
        'sans-serif',
      ],
      textTheme: textTheme,
      extensions: [tokens],
      dividerTheme: DividerThemeData(
        color: tokens.border,
        thickness: 1,
        space: 1,
      ),
      cardTheme: CardTheme(
        color: tokens.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radiusMd),
          side: BorderSide(color: tokens.border),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: tokens.background,
        foregroundColor: tokens.text,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: tokens.accent,
          foregroundColor:
              brightness == Brightness.dark ? tokens.background : Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radiusSm),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: tokens.text,
          side: BorderSide(color: tokens.border),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radiusSm),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: tokens.text,
          textStyle: textTheme.labelLarge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radiusSm),
          ),
        ),
      ),
      iconTheme: IconThemeData(color: tokens.textMuted, size: 20),
      popupMenuTheme: PopupMenuThemeData(
        color: tokens.surface,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radiusMd),
          side: BorderSide(color: tokens.border),
        ),
        textStyle: textTheme.bodyMedium,
      ),
      splashColor: tokens.accent.withOpacity(0.08),
      hoverColor: tokens.accent.withOpacity(0.06),
      highlightColor: Colors.transparent,
    );
  }

  static TextTheme _textTheme(LandingTokens tokens) {
    return TextTheme(
      displayLarge: TextStyle(
        color: tokens.text,
        fontSize: 72,
        fontWeight: FontWeight.w700,
        height: 0.98,
      ),
      displayMedium: TextStyle(
        color: tokens.text,
        fontSize: 56,
        fontWeight: FontWeight.w700,
        height: 1.02,
      ),
      headlineLarge: TextStyle(
        color: tokens.text,
        fontSize: 42,
        fontWeight: FontWeight.w700,
        height: 1.08,
      ),
      headlineMedium: TextStyle(
        color: tokens.text,
        fontSize: 32,
        fontWeight: FontWeight.w600,
        height: 1.14,
      ),
      headlineSmall: TextStyle(
        color: tokens.text,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.18,
      ),
      titleLarge: TextStyle(
        color: tokens.text,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        height: 1.25,
      ),
      titleMedium: TextStyle(
        color: tokens.text,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      titleSmall: TextStyle(
        color: tokens.text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.35,
      ),
      bodyLarge: TextStyle(
        color: tokens.textMuted,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.55,
      ),
      bodyMedium: TextStyle(
        color: tokens.textMuted,
        fontSize: 15,
        fontWeight: FontWeight.w400,
        height: 1.5,
      ),
      bodySmall: TextStyle(
        color: tokens.textMuted,
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.45,
      ),
      labelLarge: TextStyle(
        color: tokens.text,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      labelMedium: TextStyle(
        color: tokens.text,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
      labelSmall: TextStyle(
        color: tokens.textMuted,
        fontSize: 11,
        fontWeight: FontWeight.w600,
        height: 1.2,
      ),
    );
  }
}
