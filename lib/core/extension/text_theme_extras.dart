import 'package:flutter/material.dart';
import '../utils/colors.dart';

extension AppTextThemeExtras on TextTheme {
  TextStyle get error => const TextStyle(
        color: AppColors.onError,
      );

  TextStyle get success => const TextStyle(
        color: AppColors.onSuccess,
      );

  TextStyle get neutral => const TextStyle(
        color: AppColors.onNeutral,
      );

  TextStyle get muted => const TextStyle(
        color: AppColors.onSurfaceMedium,
        fontWeight: FontWeight.w500,
      );

  TextStyle get trailing => const TextStyle(
        fontSize: 12,
        color: AppColors.onSurfaceMedium,
      );
}
