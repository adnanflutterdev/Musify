import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

Widget tag(String text, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
    child: Container(
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: Text(text),
      ),
    ),
  );
}
