import 'package:musify/core/model/appearance_theme.dart';
import 'package:musify/feature/account/data/models/user/recently_played.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static late SharedPreferences _pref;

  static Future<void> initialize() async {
    _pref = await SharedPreferences.getInstance();
  }

  static String getThemeMode() {
    return _pref.getString('theme') ?? 'dark';
  }

  static void setThemeMode(String theme) {
    _pref.setString('theme', theme);
  }

  static int getAccentColorIndex() {
    return _pref.getInt('AccentColorIndex') ?? 0;
  }

  static void setAccentColorIndex(int index) {
    _pref.setInt('AccentColorIndex', index);
  }

  static String getTextSize() {
    return _pref.getString('textSize') ?? TextSize.n.fullForm;
  }

  static void setTextSize(String textSize) {
    _pref.setString('textSize', textSize);
  }

  static LastPlayedSong? getLastPlayedSong() {
    final song = _pref.getString('lastPlayedSong');
    if (song == null) return null;
    return LastPlayedSong.fromString(song);
  }

  static void setLastPlayedSong(LastPlayedSong song) {
    _pref.setString('lastPlayedSong', song.convertToString());
  }

  static void deleteLastPlayedSong() {
    _pref.remove('lastPlayedSong');
  }
}
