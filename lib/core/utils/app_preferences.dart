import 'package:musify/core/model/appearance_theme.dart';
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

  static int getAccentColorIndex()  {
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

}
