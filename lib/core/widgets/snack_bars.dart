import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

enum SnackBarType { normal, success, warning, error, info }

void showAppSnackbar({
  required BuildContext context,
  required String message,
  SnackBarType? type,
  Duration duaration = const Duration(seconds: 4),
}) {
  final colors = context.colors;
  final (bgColor, textColor) = switch (type) {
    SnackBarType.success => (colors.success, colors.onSuccess),

    SnackBarType.warning => (colors.warning, colors.onWarning),

    SnackBarType.error => (colors.error, colors.onError),

    SnackBarType.info => (colors.info, colors.onInfo),

    _ => (colors.neutral, colors.onNeutral),
  };

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        showCloseIcon: true,
        closeIconColor: context.colors.white,
        behavior: SnackBarBehavior.floating,
        duration: duaration,

        backgroundColor: bgColor,

        content: Text(
          message,
          style: context.text.bodyMedium?.copyWith(color: textColor),
        ),
      ),
    );
}
