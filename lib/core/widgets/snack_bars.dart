import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/result/result.dart';

void showAppSnackbar({
  required BuildContext context,
  required Result result,
  bool isNormal = false,
}) {
  final colors = context.colors;

  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        showCloseIcon: true,
        behavior: SnackBarBehavior.floating,

        backgroundColor: isNormal
            ? colors.surfaceVariant
            : (result.success ? colors.success : colors.error),

        content: Text(
          result.message ?? '',
          style: context.text.bodyMedium?.copyWith(
            color: isNormal
                ? null
                : (result.success ? colors.onSuccess : colors.onError),
          ),
        ),
      ),
    );
}
