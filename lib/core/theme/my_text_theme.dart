import 'package:flutter/material.dart';
import 'package:musify/core/utils/colors.dart';
// import 'colors.dart';

TextTheme myTextTheme =  TextTheme(
  // Splash / small captions
  labelSmall: TextStyle(
    fontSize: 10,
    color: AppColors.onSurfaceHigh,
  ),

  // Small body text (whiteTextSmall)
  bodySmall: TextStyle(
    fontSize: 12,
    color: AppColors.onSurfaceHigh,
  ),

  // Default body text
  bodyMedium: TextStyle(
    fontSize: 14,
    color: AppColors.onSurfaceHigh,
  ),

  // Medium emphasized text
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.onSurfaceHigh,
  ),

  // Tile title
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurfaceHigh,
  ),

  // AppBar title
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.onSurfaceHigh,
  ),

  // Section headings
  headlineSmall: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.onSurfaceLow,
  ),

  // Primary colored text
  headlineMedium: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  ),

  // Buttons
  labelLarge: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.surfaceWhite,
  ),
);
