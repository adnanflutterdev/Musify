import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

class AppShadow {
  AppShadow._();

  static BoxShadow shadowLvl1(
    BuildContext context, {
    Offset? offset,
    double? blurRadius,
  }) {
    return BoxShadow(
      offset: offset ?? const Offset(0, 1),
      blurRadius: blurRadius ?? 3,
      color: context.colors.shadowLvl1,
    );
  }

  static BoxShadow shadowLvl2(
    BuildContext context, {
    Offset? offset,
    double? blurRadius,
  }) {
    return BoxShadow(
      offset: offset ?? const Offset(0, 1),
      blurRadius: blurRadius ?? 5,
      color: context.colors.shadowLvl2,
    );
  }
}
