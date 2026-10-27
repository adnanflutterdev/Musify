import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.title,
  });
  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
        backgroundColor: context.colors.primaryLight,
      ),
      child: Text(title),
    );
  }
}
