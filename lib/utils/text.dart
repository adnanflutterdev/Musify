import 'package:flutter/material.dart';
import 'package:musify/utils/colors.dart';

Text splashScreenText(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 15, color: Colors.white),
    textAlign: TextAlign.center,
  );
}

Text musifyText() {
  return Text(
    'Musify',
    style: TextStyle(
      color: AppColors.primaryPink,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text appBarText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.textLight,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text whiteTextMicro(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 12,color: AppColors.textLight),
    overflow: TextOverflow.ellipsis,
  );
}

Text whiteTextSmall(String text) {
  return Text(
    text,
    style: TextStyle(color: AppColors.textLight),
    overflow: TextOverflow.ellipsis,
  );
}

Text tileTitle(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      color: AppColors.textLight,
      fontWeight: FontWeight.w600,
    ),
  );
}

Text tileSubTitle(String text) {
  return Text(
    text,
    style: TextStyle(color: AppColors.textMedium, fontWeight: FontWeight.w500),
  );
}

Text tileTrailing(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 12, color: AppColors.textMedium),
  );
}

Text whiteTextMedium(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.textLight,
    ),
  );
}

Text darkText(String text) {
  return Text(text, style: TextStyle(color: AppColors.textDark));
}

Text songDetailsHeading(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.textDark,
    ),
  );
}

Text primaryTextNormal(String text) {
  return Text(text, style: TextStyle(color: AppColors.primaryPink));
}

Text buttonText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
  );
}

Text errorText(String text) {
  return Text(text, style: TextStyle(color: AppColors.errorText));
}
Text successText(String text) {
  return Text(text, style: TextStyle(color: AppColors.successText));
}
Text normalText(String text) {
  return Text(text, style: TextStyle(color: AppColors.normalText));
}

Column doubleText({
  required String text1,
  required TextStyle style1,
  required String text2,
  required TextStyle style2,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text1, style: style1),
      Text(text2, style: style2),
    ],
  );
}
