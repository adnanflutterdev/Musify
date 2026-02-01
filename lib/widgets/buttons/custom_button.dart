import 'package:flutter/material.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/text.dart';

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
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
        backgroundColor: AppColors.primaryVariant,
      ),
      child: whiteTextSmall(title),
    );
  }
}
