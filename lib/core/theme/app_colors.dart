import 'package:flutter/material.dart';
import 'package:musify/core/utils/app_preferences.dart';

class AppThemeColors {
  AppThemeColors._();

  // ============================================================
  // BRAND / PRIMARY
  // ============================================================

  static const List<Color> primary = [
    // Original Accent Color(Pink)
    Color(0xFFF472B6),
    // Purple
    Color(0xFFA78BFA),
    // Electric blue
    Color(0xFF60A5FA),
    // Cyan
    Color(0xFF22D3EE),
  ];
  static const List<Color> primaryDark = [
    // Original Accent Color(Pink)
    Color(0xFFEC4899),
    // Purple
    Color(0xFF8B5CF6),
    // Electric blue
    Color(0xFF3B82F6),
    // Cyan
    Color(0xFF06B6D4),
  ];
  static const List<Color> primaryLight = [
    // Original Accent Color(Pink)
    Color(0xFFF9A8D4),
    // Purple
    Color(0xFFC4B5FD),
    // Electric blue
    Color(0xFF93C5FD),
    // Cyan
    Color(0xFF67E8F9),
  ];

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
  static const Color lightTextSecondary = Color(0xFF374151);
  static const Color lightTextTertiary = Color(0xFF9CA3AF);

  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightDivider = Color(0xFFE5E7EB);

  // Shadow
  static const Color lightShadowLvl1 = Colors.black26;
  static const Color lightShadowLvl2 = Colors.black38;

  // Gradient for appbar,navbar,etc.
  static const List<Color> lightGradient = [
    Color(0xFFF9FAFB),
    Color(0xFFFCFCFD),
    Color(0xFFFFFFFF),
  ];

  static const List<double> gradientStopsT = [0.0, 0.3, 1.0];
  static const List<double> gradientStopsR = [0.0, 0.7, 1.0];

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

  // Gradient for appbar,navbar,etc.
  static const List<Color> darkGradient = [
    Color(0xFF111827),
    Color(0xFF182130),
    Color(0xFF1F2937),
  ];

  // ============================================================
  // STATUS
  // ============================================================

  // Light theme
  static const Color lightError = Color(0xFFB91C1C);
  static const Color lightSuccess = Color(0xFF166534);
  static const Color lightWarning = Color(0xFF92400E);
  static const Color lightInfo = Color(0xFF1D4ED8);

  // Dark theme
  static const Color darkError = Color(0xFFB91C1C);
  static const Color darkSuccess = Color(0xFF4ADE80);
  static const Color darkWarning = Color(0xFFFBBF24);
  static const Color darkInfo = Color(0xFF60A5FA);

  static const Color onError = Color(0xFFFEE2E2);
  static const Color onSuccess = Color(0xFFDCFCE7);
  static const Color onWarning = Color(0xFFFEF3C7);
  static const Color onInfo = Color(0xFFDBEAFE);

  // ============================================================
  // NEUTRAL
  // ============================================================

  static const Color neutral = Color(0xFF4B5563);
  static const Color onNeutral = Color(0xFFE5E7EB);

  // ============================================================
  // COMMON
  // ============================================================

  static const Color scrim = Color(0x66000000);

  // Light theme
  static const Color lightDisabled = Color(0xFFD1D5DB);
  static const Color lightSelection = Color(0xFFFCE7F3);
  static const Color lightSkeleton = Color(0xFFE5E7EB);

  // Dark theme
  static const Color darkDisabled = Color(0xFF4B5563);
  static const Color darkSelection = Color(0xFF831843);
  static const Color darkSkeleton = Color(0xFF374151);

  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;

  static const Color textFieldError = Color(0xFFFF4040);

  static AppColors getColors(Brightness brightness) {
    final index = AppPreferences.getAccentColorIndex();
    if (brightness == .dark) {
      return AppColors(
        primary: primary[index],
        primaryDark: primaryDark[index],
        primaryLight: primaryLight[index],
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
        gradient: darkGradient,
        gradientStopsT: gradientStopsT,
        gradientStopsR: gradientStopsR,
        error: darkError,
        onError: onError,
        success: darkSuccess,
        onSuccess: onSuccess,
        warning: darkWarning,
        onWarning: onWarning,
        info: darkInfo,
        onInfo: onInfo,
        neutral: neutral,
        onNeutral: onNeutral,
        white: white,
        black: black,
        transparent: transparent,
        textFieldError: textFieldError,
        scrim: scrim,
        disabled: darkDisabled,
        selection: darkSelection,
        skeleton: darkSelection,
      );
    } else {
      return AppColors(
        primary: primary[index],
        primaryDark: primaryDark[index],
        primaryLight: primaryLight[index],
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
        gradient: lightGradient,
        gradientStopsT: gradientStopsT,
        gradientStopsR: gradientStopsR,
        error: lightError,
        onError: onError,
        success: lightSuccess,
        onSuccess: onSuccess,
        warning: lightWarning,
        onWarning: onWarning,
        info: lightInfo,
        onInfo: onInfo,
        neutral: neutral,
        onNeutral: onNeutral,
        white: white,
        black: black,
        transparent: transparent,
        textFieldError: textFieldError,
        scrim: scrim,
        disabled: lightDisabled,
        selection: lightSelection,
        skeleton: lightSelection,
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
  final List<Color> gradient;
  final List<double> gradientStopsT;
  final List<double> gradientStopsR;
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

  final Color scrim;
  final Color disabled;
  final Color selection;
  final Color skeleton;

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
    required this.gradient,
    required this.gradientStopsT,
    required this.gradientStopsR,
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
    required this.scrim,
    required this.disabled,
    required this.selection,
    required this.skeleton,
  });
}
