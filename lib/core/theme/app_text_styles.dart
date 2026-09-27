import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String poppins = 'Poppins';
  static const String serif = 'Serif';

  // ============================================================
  // DISPLAY
  // ============================================================

  static const TextStyle displayLarge = TextStyle(
    fontFamily: serif,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    height: 1.2,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: poppins,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 1.2,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: poppins,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    height: 1.25,
  );

  // ============================================================
  // HEADINGS
  // ============================================================

  static const TextStyle headlineLarge = TextStyle(
    fontFamily: poppins,
    fontSize: 22,
    fontWeight: FontWeight.w700,
    height: 1.3,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontFamily: poppins,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontFamily: poppins,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // ============================================================
  // TITLES
  // ============================================================

  static const TextStyle titleLarge = TextStyle(
    fontFamily: poppins,
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: poppins,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: poppins,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ============================================================
  // BODY
  // ============================================================

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: poppins,
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: poppins,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  // ============================================================
  // LABELS
  // ============================================================

  static const TextStyle labelLarge = TextStyle(
    fontFamily: poppins,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: poppins,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: poppins,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
}