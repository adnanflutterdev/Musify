import 'package:flutter/material.dart';

enum TextSize {
  xs('Extra Small'),
  s('Small'),
  n('Normal'),
  l('Large'),
  xl('Extra Large');

  final String fullForm;
  const TextSize(this.fullForm);
}

extension TextSizeX on TextSize {
  static TextSize fromJson(String s) =>
      TextSize.values.firstWhere((v) => v.fullForm == s);

  static TextScaler getScaler(TextSize s) => switch (s) {
    TextSize.xs => const .linear(0.8),
    TextSize.s => const .linear(0.9),
    TextSize.n => const .linear(1.0),
    TextSize.l => const .linear(1.1),
    TextSize.xl => const .linear(1.2),
  };
}

class AppearanceTheme {
  final ThemeMode themeMode;
  final int accentColorIndex;
  final TextSize textSize;

  AppearanceTheme({
    required this.themeMode,
    required this.accentColorIndex,
    required this.textSize,
  });

  AppearanceTheme copyWith({
    ThemeMode? themeMode,
    int? accentColorIndex,
    TextSize? textSize,
  }) {
    return AppearanceTheme(
      themeMode: themeMode ?? this.themeMode,
      accentColorIndex: accentColorIndex ?? this.accentColorIndex,
      textSize: textSize ?? this.textSize,
    );
  }
}
