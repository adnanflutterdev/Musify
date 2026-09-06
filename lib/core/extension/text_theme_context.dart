import 'package:flutter/material.dart';

extension AppTextThemeContext on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
