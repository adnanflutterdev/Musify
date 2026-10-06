import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

class AttentionDialog({
  required this.title,
  required this.content,
  required this.actionlabel,
  required this.action,
}) {
  final String title;
  final String content;
  final String actionlabel;
  final VoidCallback action;
}

class AppDialogs {
  static void showAttentionDialog({
    required BuildContext context,
    required AttentionDialog dialog,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.warning, color: context.colors.error, size: 30),
              AppSpacing.w12,
              Text(
                dialog.title,
                style: context.text.titleLarge?.copyWith(
                  color: context.colors.onError,
                ),
              ),
            ],
          ),

          content: Text(dialog.content),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'cancel',
                style: context.text.bodyMedium?.copyWith(
                  color: context.colors.textPrimary,
                ),
              ),
            ),
            TextButton(
              onPressed: dialog.action,
              child: Text(
                dialog.actionlabel,
                style: context.text.bodyLarge?.copyWith(
                  color: context.colors.error,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showInfoDialog() {}
}
