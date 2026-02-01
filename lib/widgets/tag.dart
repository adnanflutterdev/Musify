import 'package:flutter/material.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text.dart';

Widget tag(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: BorderRadius.circular(18),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        child: whiteTextSmall(text),
      ),
    ),
  );
}
