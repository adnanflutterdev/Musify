import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/model/appearance_theme.dart';
import 'package:musify/core/utils/app_preferences.dart';

extension ThemeModeX on ThemeMode {
  static ThemeMode getThemeMode(String theme) {
    return ThemeMode.values.firstWhere((mode) => mode.name == theme);
  }
}

class ThemeNotifier extends Notifier<AppearanceTheme> {
  @override
  AppearanceTheme build() {
    return _initialize();
  }

  AppearanceTheme _initialize() {
    String theme = AppPreferences.getThemeMode();
    int index = AppPreferences.getAccentColorIndex();
    String scale = AppPreferences.getTextSize();

    return AppearanceTheme(
      themeMode: ThemeModeX.getThemeMode(theme),
      accentColorIndex: index,
      textSize: TextSizeX.fromJson(scale),
    );
  }

  void changeThemeMode(ThemeMode mode) {
    state = state.copyWith(themeMode: mode);
    AppPreferences.setThemeMode(mode.name);
  }

  void changeAccentColor(int index) {
    state = state.copyWith(accentColorIndex: index);
    AppPreferences.setAccentColorIndex(index);
  }

  void changeTextSize(TextSize size) {
    state = state.copyWith(textSize: size);
    AppPreferences.setTextSize(size.fullForm);
  }
}

final appearanceProvider = NotifierProvider(() => ThemeNotifier());
