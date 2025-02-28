import 'package:flutter/material.dart';
import 'style.dart';

/// Contains all text styles used in the app
/// Naming convention: w{weight}p{size}
/// Example: w600p12 means weight 600, text size 12
class AppTextStyles {
  // Regular weight (w400) text styles
  static const TextStyle w400p10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w400p12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w400p14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w400p16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w400p18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w400p20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.hologramWhite,
  );

  // Medium weight (w500) text styles
  static const TextStyle w500p10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w500p12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w500p14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w500p16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w500p18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w500p20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.hologramWhite,
  );

  // Semi-bold weight (w600) text styles
  static const TextStyle w600p10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w600p12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w600p14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w600p16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w600p18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w600p20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
  );

  // Bold weight (w700) text styles
  static const TextStyle w700p10 = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w700p12 = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w700p14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w700p16 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w700p18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w700p20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  // Extra Bold weight (w800) text styles for headings
  static const TextStyle w800p22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w800p24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w800p28 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w800p32 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.hologramWhite,
  );

  // Larger sizes for display text
  static const TextStyle w700p36 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  static const TextStyle w700p48 = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: AppColors.hologramWhite,
  );

  // Special text styles
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.ghostBlue,
    letterSpacing: 0.4,
  );

  static const TextStyle button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.hologramWhite,
    letterSpacing: 1.0,
    height: 1.5,
  );

  static const TextStyle overline = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.matrixSilver,
    letterSpacing: 1.5,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle link = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.neonAqua,
    decoration: TextDecoration.underline,
  );
}
