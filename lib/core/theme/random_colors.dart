import 'dart:math';
import 'package:flutter/material.dart';

class RandomColors {
  static final Random _random = Random();

  // Base colors with good visual harmony
  static const List<Color> _baseColors = [
    Color(0xFF6366F1), // Indigo
    Color(0xFFEC4899), // Pink
    Color(0xFF8B5CF6), // Purple
    Color(0xFFF59E0B), // Amber
    Color(0xFF06B6D4), // Cyan
    Color(0xFF10B981), // Emerald
    Color(0xFF3B82F6), // Blue
    Color(0xFFF43F5E), // Rose
    Color(0xFF8B5CF6), // Violet
    Color(0xFF6366F1), // Indigo
  ];

  static List<Color> getRandomGradient({double opacity = 0.15}) {
    final baseColor = _baseColors[_random.nextInt(_baseColors.length)];

    return [
      baseColor.withOpacity(opacity),
      baseColor.withOpacity(0.0),
    ];
  }

  static Color getRandomColor({double opacity = 1.0}) {
    final color = _baseColors[_random.nextInt(_baseColors.length)];
    return color.withOpacity(opacity);
  }

  // Get a harmonious pair of colors (analogous colors)
  static List<Color> getHarmoniousPair({double opacity = 0.15}) {
    final startIndex = _random.nextInt(_baseColors.length - 1);
    return [
      _baseColors[startIndex].withOpacity(opacity),
      _baseColors[startIndex + 1].withOpacity(opacity),
    ];
  }
}
