import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,

    this.icon,
    this.leading,
    this.style,
    this.width,
    this.height,
    this.iconSize,
    this.progress,
    this.backgroundColor,
    this.foregroundColor,
    this.buildFull = false,
    this.isLoading = false,
    this.alignment = .start,
    this.elevation = 0,
  });
  final VoidCallback? onPressed;
  final String label;

  final IconData? icon;
  final Widget? leading;
  final double? width;
  final double? height;
  final double? elevation;
  final bool buildFull;
  final bool isLoading;
  final double? progress;
  final double? iconSize;
  final TextStyle? style;
  final IconAlignment alignment;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (buildFull ? double.infinity : null),
      height: height ?? 56,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        label: Text(
          (isLoading && progress != null && progress! < 100)
              ? '${progress!.toStringAsFixed(2)} %'
              : label,
          style:
              style ??
              context.text.headlineMedium?.copyWith(
                color: foregroundColor ?? context.colors.white,
              ),
        ),

        icon: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  value: (progress != null && progress! > 0)
                      ? (progress! / 100)
                      : null,
                  color: context.colors.white,
                ),
              )
            : (leading != null)
            ? leading
            : (icon != null)
            ? Icon(icon)
            : null,

        style: ElevatedButton.styleFrom(
          elevation: elevation,

          backgroundColor: backgroundColor ?? context.colors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(AppSpacing.radiusLg),
            side: BorderSide(width: 0.1, color: context.colors.shadowLvl1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          iconAlignment: alignment,
          iconSize: iconSize,
          iconColor: foregroundColor ?? context.colors.white,
          disabledBackgroundColor: context.colors.primary.withValues(
            alpha: 0.5,
          ),
          shadowColor: context.colors.shadowLvl2,
        ),
      ),
    );
  }
}
