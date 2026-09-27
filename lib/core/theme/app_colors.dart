import 'package:flutter/material.dart';

class AppThemeColors {
  AppThemeColors._();

  // ============================================================
  // BRAND / PRIMARY
  // ============================================================

  static const Color primary = Color(0xFFF472B6);
  static const Color primaryDark = Color(0xFFEC4899);
  static const Color primaryLight = Color(0xFFF9A8D4);

  // ============================================================
  // LIGHT THEME
  // ============================================================

  // Main page background
  static const Color lightBackground = Color(0xFFF9FAFB);

  // AppBar / Cards / Main surfaces
  static const Color lightSurface = Color(0xFFFFFFFF);

  // Slightly contrasted surface
  static const Color lightSurfaceVariant = Color(0xFFF3F4F6);

  static const Color lightTextPrimary = Color(0xFF111827);
  static const Color lightTextSecondary = Color(0xFF4B5563);
  static const Color lightTextTertiary = Color(0xFF6B7280);

  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightDivider = Color(0xFFE5E7EB);

    // Shadow
  static const Color lightShadowLvl1 = Colors.black26;
  static const Color lightShadowLvl2 = Colors.black38;

  // ============================================================
  // DARK THEME
  // ============================================================

  // Main page background
  static const Color darkBackground = Color(0xFF111827);

  // AppBar / Cards
  static const Color darkSurface = Color(0xFF1F2937);

  // Elevated / secondary surfaces
  static const Color darkSurfaceVariant = Color(0xFF374151);

  static const Color darkTextPrimary = Color(0xFFF9FAFB);
  static const Color darkTextSecondary = Color(0xFFD1D5DB);
  static const Color darkTextTertiary = Color(0xFF9CA3AF);

  static const Color darkBorder = Color(0xFF374151);
  static const Color darkDivider = Color(0xFF374151);

  // Shadow
  static const Color darkShadowLvl1 = Color(0x00000000);
  static const Color darkShadowLvl2 = Color(0x00000000);

  // ============================================================
  // STATUS
  // ============================================================

  static const Color error = Color(0xFFB91C1C);
  static const Color onError = Color(0xFFFEE2E2);

  static const Color success = Color(0xFF297D48);
  static const Color onSuccess = Color(0xFFDCFCE7);

  static const Color warning = Color(0xFFD97706);
  static const Color onWarning = Color(0xFFFEF3C7);

  static const Color info = Color(0xFF2563EB);
  static const Color onInfo = Color(0xFFDBEAFE);

  // ============================================================
  // NEUTRAL
  // ============================================================

  static const Color neutral = Color(0xFF4B5563);
  static const Color onNeutral = Color(0xFFE5E7EB);

  // ============================================================
  // COMMON
  // ============================================================

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  static const Color textFieldError = Color(0xFFFF4040);

  static AppColors getColors(Brightness brightness) {
    if (brightness == .dark) {
      return AppColors(
        primary: primary,
        primaryDark: primaryDark,
        primaryLight: primaryLight,
        background: darkBackground,
        surface: darkSurface,
        surfaceVariant: darkSurfaceVariant,
        textPrimary: darkTextPrimary,
        textSecondary: darkTextSecondary,
        textTertiary: darkTextTertiary,
        border: darkBorder,
        divider: darkDivider,
        shadowLvl1: darkShadowLvl1,
        shadowLvl2: darkShadowLvl2,
        error: error,
        onError: onError,
        success: success,
        onSuccess: onSuccess,
        warning: warning,
        onWarning: onWarning,
        info: info,
        onInfo: onInfo,
        neutral: neutral,
        onNeutral: onNeutral,
        white: white,
        black: black,
        transparent: transparent,
        textFieldError: textFieldError,
      );
    } else {
      return AppColors(
        primary: primary,
        primaryDark: primaryDark,
        primaryLight: primaryLight,
        background: lightBackground,
        surface: lightSurface,
        surfaceVariant: lightSurfaceVariant,
        textPrimary: lightTextPrimary,
        textSecondary: lightTextSecondary,
        textTertiary: lightTextTertiary,
        border: lightBorder,
        divider: lightDivider,
        shadowLvl1: lightShadowLvl1,
        shadowLvl2: lightShadowLvl2,
        error: error,
        onError: onError,
        success: success,
        onSuccess: onSuccess,
        warning: warning,
        onWarning: onWarning,
        info: info,
        onInfo: onInfo,
        neutral: neutral,
        onNeutral: onNeutral,
        white: white,
        black: black,
        transparent: transparent,
        textFieldError: textFieldError,
      );
    }
  }
}

class AppColors {
  // Primary Colors
  final Color primary;
  final Color primaryDark;
  final Color primaryLight;

  // Main page background
  final Color background;
  // AppBar / Cards
  final Color surface;
  // Elevated / secondary surfaces
  final Color surfaceVariant;

  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color border;
  final Color divider;
  final Color shadowLvl1;
  final Color shadowLvl2;
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;
  final Color neutral;
  final Color onNeutral;
  final Color white;
  final Color black;
  final Color transparent;
  final Color textFieldError;

  AppColors({
    required this.primary,
    required this.primaryDark,
    required this.primaryLight,
    required this.background,
    required this.surface,
    required this.surfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.border,
    required this.divider,
    required this.shadowLvl1,
    required this.shadowLvl2,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    required this.neutral,
    required this.onNeutral,
    required this.white,
    required this.black,
    required this.transparent,
    required this.textFieldError,
  });
}
