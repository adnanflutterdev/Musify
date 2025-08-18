import 'package:flutter/material.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/text.dart';

enum SnackBarType { normal, success, error }

void showAppSnackbar({
  required BuildContext context,
  required String message,
  SnackBarType snackBarType = SnackBarType.normal,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    snackBarType == SnackBarType.normal
        ? SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,

            backgroundColor: AppColors.neutral,
            content: normalText(message),
          )
        : snackBarType == SnackBarType.success
        ? SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.success,
            content: successText(message),
          )
        : SnackBar(
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.error,
            content: errorText(message),
          ),
  );
}
