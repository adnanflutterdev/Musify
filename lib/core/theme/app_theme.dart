import 'package:flutter/material.dart';
import 'package:musify/core/utils/app_preferences.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static Color get primary {
    final index = AppPreferences.getAccentColorIndex();
    return AppThemeColors.primary[index];
  }

  static Color get primaryDark {
    final index = AppPreferences.getAccentColorIndex();
    return AppThemeColors.primaryDark[index];
  }

  static Color get primaryLight {
    final index = AppPreferences.getAccentColorIndex();
    return AppThemeColors.primaryLight[index];
  }

  // ============================================================
  // LIGHT THEME
  // ============================================================

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    fontFamily: AppTextStyles.poppins,

    colorScheme: ColorScheme.light(
      primary: primary,
      onPrimary: AppThemeColors.white,

      secondary: primaryDark,
      onSecondary: AppThemeColors.white,

      error: AppThemeColors.lightError,
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
        borderSide: BorderSide(color: primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.lightError),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: AppThemeColors.lightError,
          width: 2,
        ),
      ),

      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.lightTextTertiary,
      ),

      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.lightTextSecondary,
      ),

      errorStyle: AppTextStyles.bodySmall.copyWith(
        color: AppThemeColors.lightError,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: AppThemeColors.white,

        elevation: 0,

        minimumSize: const Size(double.infinity, 50),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,

        minimumSize: const Size(double.infinity, 50),

        side: BorderSide(color: primary),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: AppThemeColors.white,
      elevation: 2,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppThemeColors.lightSurface,
      selectedItemColor: primary,
      unselectedItemColor: AppThemeColors.lightTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppThemeColors.lightSurface,
      indicatorColor: primary.withValues(alpha: 0.15),

      labelTextStyle: const WidgetStatePropertyAll(AppTextStyles.labelSmall),

      iconTheme: const WidgetStatePropertyAll(IconThemeData(size: 24)),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: AppThemeColors.lightSurfaceVariant,
      thumbColor: primary,
      overlayColor: primary.withValues(alpha: 0.15),
      trackHeight: 4,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),

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
      selectedColor: primary,
      labelStyle: AppTextStyles.labelMedium,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),


  );

  // ============================================================
  // DARK THEME
  // ============================================================

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    fontFamily: AppTextStyles.poppins,

    colorScheme: ColorScheme.dark(
      primary: primary,
      onPrimary: AppThemeColors.white,

      secondary: primaryDark,
      onSecondary: AppThemeColors.white,

      error: AppThemeColors.darkError,
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
        borderSide: BorderSide(color: primary, width: 2),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.darkError),
      ),

      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppThemeColors.darkError, width: 2),
      ),

      hintStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.darkTextTertiary,
      ),

      labelStyle: AppTextStyles.bodyMedium.copyWith(
        color: AppThemeColors.darkTextSecondary,
      ),

      errorStyle: AppTextStyles.bodySmall.copyWith(
        color: AppThemeColors.darkError,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: AppThemeColors.white,

        elevation: 0,

        minimumSize: const Size(double.infinity, 50),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primary,

        minimumSize: const Size(double.infinity, 50),

        side: BorderSide(color: primary),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),

        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primary,
        textStyle: AppTextStyles.labelLarge,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: AppThemeColors.white,
      elevation: 2,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppThemeColors.darkSurface,
      selectedItemColor: primary,
      unselectedItemColor: AppThemeColors.darkTextTertiary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppThemeColors.darkSurface,
      indicatorColor: primary.withValues(alpha: 0.15),

      labelTextStyle: const WidgetStatePropertyAll(AppTextStyles.labelSmall),

      iconTheme: const WidgetStatePropertyAll(IconThemeData(size: 24)),
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primary,
      inactiveTrackColor: AppThemeColors.darkSurfaceVariant,
      thumbColor: primary,
      overlayColor: primary.withValues(alpha: 0.15),
      trackHeight: 4,
    ),

    progressIndicatorTheme: ProgressIndicatorThemeData(color: primary),

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
      selectedColor: primary,
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
