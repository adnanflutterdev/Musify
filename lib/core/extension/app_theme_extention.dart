import 'package:flutter/material.dart';
import 'package:musify/core/theme/app_colors.dart';

extension AppThemeExtention on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get text => theme.textTheme;
  AppColors get colors => AppThemeColors.getColors(theme.brightness);
}
