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
      color: AppColors.primary,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text appBarText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.onSurfaceHigh,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text whiteTextMicro(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 12, color: AppColors.onSurfaceHigh),
    overflow: TextOverflow.ellipsis,
  );
}

Text whiteTextSmall(String text) {
  return Text(
    text,
    style: TextStyle(color: AppColors.onSurfaceHigh),
    overflow: TextOverflow.ellipsis,
  );
}

Text tileTitle(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 16,
      color: AppColors.onSurfaceHigh,
      fontWeight: FontWeight.w600,
    ),
  );
}

Text tileSubTitle(String text) {
  return Text(
    text,
    style: TextStyle(
      color: AppColors.onSurfaceMedium,
      fontWeight: FontWeight.w500,
    ),
  );
}

Text tileTrailing(String text) {
  return Text(
    text,
    style: TextStyle(fontSize: 12, color: AppColors.onSurfaceMedium),
  );
}

Text whiteTextMedium(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.onSurfaceHigh,
    ),
  );
}

Text darkText(String text) {
  return Text(text, style: TextStyle(color: AppColors.onSurfaceLow));
}

Text songDetailsHeading(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurfaceLow,
    ),
  );
}

Text primaryTextNormal(String text) {
  return Text(text, style: TextStyle(color: AppColors.primary));
}

Text primaryTextMedium(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      color: AppColors.primary,
      fontWeight: FontWeight.bold,
    ),
  );
}

Text buttonText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: AppColors.surfaceWhite,
    ),
  );
}

Text errorText(String text) {
  return Text(text, style: TextStyle(color: AppColors.onError));
}

Text successText(String text) {
  return Text(text, style: TextStyle(color: AppColors.onSuccess));
}

Text normalText(String text) {
  return Text(text, style: TextStyle(color: AppColors.onNeutral));
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
