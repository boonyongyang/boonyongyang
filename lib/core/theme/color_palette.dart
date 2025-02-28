import 'package:flutter/material.dart';

class ColorPalette {
  // Base colors
  static const Color darkBackground = Color(0xFF030303);
  static const Color darkSurface = Color(0xFF121212);
  static const Color darkCard = Color(0xFF1E1E1E);

  // Accent colors with opacity variants
  static final accentColors = {
    'indigo': Colors.indigo.withOpacity(0.15),
    'rose': Colors.pink.withOpacity(0.15),
    'violet': Colors.purple.withOpacity(0.15),
    'amber': Colors.amber.withOpacity(0.15),
    'cyan': Colors.cyan.withOpacity(0.15),
  };

  // Gradients
  static final heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.indigo.withOpacity(0.05),
      Colors.transparent,
      Colors.pink.withOpacity(0.05),
    ],
  );

  static final glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Colors.white.withOpacity(0.1),
      Colors.white.withOpacity(0.05),
    ],
  );

  // Overlays and effects
  static final glassEffect = BoxDecoration(
    color: Colors.white.withOpacity(0.03),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.08)),
    boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.02),
        blurRadius: 32,
        spreadRadius: -8,
      ),
    ],
  );

  static final cardGlow = [
    BoxShadow(
      color: Colors.white.withOpacity(0.02),
      blurRadius: 20,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.5),
      blurRadius: 20,
      spreadRadius: -10,
    ),
  ];

  // Text colors
  static const textPrimary = Colors.white;
  static final textSecondary = Colors.white.withOpacity(0.7);
  static final textTertiary = Colors.white.withOpacity(0.4);

  // Gradient text
  static final titleGradient = LinearGradient(
    colors: [
      Colors.white,
      Colors.white.withOpacity(0.8),
    ],
  );

  static final accentTitleGradient = LinearGradient(
    colors: [
      Colors.indigo.shade300,
      Colors.white.withOpacity(0.9),
      Colors.pink.shade300,
    ],
  );
}
