import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    fontFamily: AppTextStyles.poppins,

    colorScheme: const ColorScheme.light(
      primary: AppThemeColors.primary,
      onPrimary: AppThemeColors.white,

      secondary: AppThemeColors.primaryDark,
      onSecondary: AppThemeColors.white,

      error: AppThemeColors.error,
      onError: AppThemeColors.onError,

      surface: AppThemeColors.lightSurface,
      onSurface: AppThemeColors.lightTextPrimary,
      onInverseSurface: AppThemeColors.lightSurface,

      surfaceContainerHighest: AppThemeColors.lightSurfaceVariant,
      onSurfaceVariant: AppThemeColors.lightTextSecondary,
    ),

    scaffoldBackgroundColor: AppThemeColors.lightBackground,

    textTheme: _lightTextTheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppThemeColors.lightSurface,
      foregroundColor: AppThemeColors.lightTextPrimary,
      elevation: 1,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),

    cardTheme: const CardThemeData(
      color: AppThemeColors.lightSurface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppThemeColors.lightDivider,
      thickness: 1,
      space: 1,
    ),

    iconTheme: const IconThemeData(
      color: AppThemeColors.lightTextPrimary,
      size: 24,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppThemeColors.lightSurfaceVariant,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.lightBorder),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.lightBorder),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.error),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.error, width: 2),
      ),

      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.lightTextTertiary,
      ),

      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.lightTextSecondary,
      ),

      errorStyle: AppTextStyles.bodySmall.copyWith(color: AppThemeColors.error),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeColors.primary,
        foregroundColor: AppThemeColors.white,

        elevation: 0,

        minimumSize: const Size(double.infinity, 50),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppThemeColors.primary,

        minimumSize: const Size(double.infinity, 50),

        side: const BorderSide(color: AppThemeColors.primary),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppThemeColors.primary,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppThemeColors.primary,
      foregroundColor: AppThemeColors.white,
      elevation: 2,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppThemeColors.lightSurface,
      selectedItemColor: AppThemeColors.primary,
      unselectedItemColor: AppThemeColors.lightTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppThemeColors.lightSurface,
      indicatorColor: AppThemeColors.primary.withValues(alpha: 0.15),

      labelTextStyle: const WidgetStatePropertyAll(AppTextStyles.labelSmall),

      iconTheme: const WidgetStatePropertyAll(IconThemeData(size: 24)),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppThemeColors.primary,
      inactiveTrackColor: AppThemeColors.lightSurfaceVariant,
      thumbColor: AppThemeColors.primary,
      overlayColor: AppThemeColors.primary.withValues(alpha: 0.15),
      trackHeight: 4,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppThemeColors.primary,
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppThemeColors.lightTextPrimary,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.white,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppThemeColors.lightSurfaceVariant,
      selectedColor: AppThemeColors.primary,
      labelStyle: AppTextStyles.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    fontFamily: AppTextStyles.poppins,

    colorScheme: const ColorScheme.dark(
      primary: AppThemeColors.primary,
      onPrimary: AppThemeColors.white,

      secondary: AppThemeColors.primaryDark,
      onSecondary: AppThemeColors.white,

      error: AppThemeColors.error,
      onError: AppThemeColors.onError,

      surface: AppThemeColors.darkSurface,
      onSurface: AppThemeColors.darkTextPrimary,
      onInverseSurface: AppThemeColors.darkSurface,

      surfaceContainerHighest: AppThemeColors.darkSurfaceVariant,
      onSurfaceVariant: AppThemeColors.darkTextSecondary,
    ),

    scaffoldBackgroundColor: AppThemeColors.darkBackground,

    textTheme: _darkTextTheme,

    appBarTheme: const AppBarTheme(
      backgroundColor: AppThemeColors.darkSurface,
      foregroundColor: AppThemeColors.darkTextPrimary,
      elevation: 0,
      centerTitle: false,
      scrolledUnderElevation: 0,
    ),

    cardTheme: const CardThemeData(
      color: AppThemeColors.darkSurface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),

    dividerTheme: const DividerThemeData(
      color: AppThemeColors.darkDivider,
      thickness: 1,
      space: 1,
    ),

    iconTheme: const IconThemeData(
      color: AppThemeColors.darkTextPrimary,
      size: 24,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppThemeColors.darkSurfaceVariant,

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.darkBorder),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.darkBorder),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.textFieldError),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppThemeColors.textFieldError,
          width: 2,
        ),
      ),

      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.darkTextTertiary,
      ),

      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.darkTextSecondary,
      ),

      errorStyle: AppTextStyles.bodySmall.copyWith(
        color: AppThemeColors.textFieldError,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeColors.primary,
        foregroundColor: AppThemeColors.white,

        elevation: 0,

        minimumSize: const Size(double.infinity, 50),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppThemeColors.primary,

        minimumSize: const Size(double.infinity, 50),

        side: const BorderSide(color: AppThemeColors.primary),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppThemeColors.primary,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppThemeColors.primary,
      foregroundColor: AppThemeColors.white,
      elevation: 2,
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppThemeColors.darkSurface,
      selectedItemColor: AppThemeColors.primary,
      unselectedItemColor: AppThemeColors.darkTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppThemeColors.darkSurface,
      indicatorColor: AppThemeColors.primary.withValues(alpha: 0.15),

      labelTextStyle: const WidgetStatePropertyAll(AppTextStyles.labelSmall),

      iconTheme: const WidgetStatePropertyAll(IconThemeData(size: 24)),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: AppThemeColors.primary,
      inactiveTrackColor: AppThemeColors.darkSurfaceVariant,
      thumbColor: AppThemeColors.primary,
      overlayColor: AppThemeColors.primary.withValues(alpha: 0.15),
      trackHeight: 4,
    ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppThemeColors.primary,
    ),

    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppThemeColors.darkSurfaceVariant,
      contentTextStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    chipTheme: ChipThemeData(
      backgroundColor: AppThemeColors.darkSurfaceVariant,
      selectedColor: AppThemeColors.primary,
      labelStyle: AppTextStyles.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  );

  // ============================================================
  // LIGHT TEXT THEME
  // ============================================================

  static TextTheme get _lightTextTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),

      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),

      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppThemeColors.lightTextSecondary,
      ),

      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.lightTextSecondary,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppThemeColors.lightTextTertiary,
      ),

      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppThemeColors.lightTextPrimary,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: AppThemeColors.lightTextSecondary,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: AppThemeColors.lightTextTertiary,
      ),
    );
  }

  // ============================================================
  // DARK TEXT THEME
  // ============================================================

  static TextTheme get _darkTextTheme {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      displayMedium: AppTextStyles.displayMedium.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      displaySmall: AppTextStyles.displaySmall.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),

      headlineLarge: AppTextStyles.headlineLarge.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      headlineMedium: AppTextStyles.headlineMedium.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      headlineSmall: AppTextStyles.headlineSmall.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),

      titleLarge: AppTextStyles.titleLarge.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      titleMedium: AppTextStyles.titleMedium.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      titleSmall: AppTextStyles.titleSmall.copyWith(
        color: AppThemeColors.darkTextSecondary,
      ),

      bodyLarge: AppTextStyles.bodyLarge.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      bodyMedium: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.darkTextSecondary,
      ),
      bodySmall: AppTextStyles.bodySmall.copyWith(
        color: AppThemeColors.darkTextTertiary,
      ),

      labelLarge: AppTextStyles.labelLarge.copyWith(
        color: AppThemeColors.darkTextPrimary,
      ),
      labelMedium: AppTextStyles.labelMedium.copyWith(
        color: AppThemeColors.darkTextSecondary,
      ),
      labelSmall: AppTextStyles.labelSmall.copyWith(
        color: AppThemeColors.darkTextTertiary,
      ),
    );
  }
}
