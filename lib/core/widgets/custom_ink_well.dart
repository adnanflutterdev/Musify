import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

class CustomInkWell extends StatelessWidget {
  const CustomInkWell({
    super.key,
    required this.child,
    required this.onTap,
    this.splashColor,
    this.backgroudColor,
    this.borderRadius,
    this.borderSide,
    this.isCircular = false,
  });
  final Widget child;
  final VoidCallback onTap;
  final Color? splashColor;
  final Color? backgroudColor;
  final double? borderRadius;
  final BorderSide? borderSide;
  final bool isCircular;

  @override
  Widget build(BuildContext context) {
    final shape = isCircular
        ? CircleBorder(side: borderSide ?? .none)
        : RoundedRectangleBorder(
            side: borderSide ?? .none,
            borderRadius: BorderRadius.circular(
              borderRadius ?? AppSpacing.radiusMd,
            ),
          );
    return Material(
      color: backgroudColor ?? context.colors.transparent,
      shape: shape,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        splashColor: splashColor ?? context.colors.selection,
        child: child,
      ),
    );
  }
}
