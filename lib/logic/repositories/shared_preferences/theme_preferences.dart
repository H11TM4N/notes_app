import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static late SharedPreferences _themePrefs;

  static Future init() async =>
      _themePrefs = await SharedPreferences.getInstance();

  static const _themeKey = 'isDarkMode';

  static Future saveTheme(bool isDarkMode) async {
    await _themePrefs.setBool(_themeKey, isDarkMode);
  }

  static bool? getTheme() {
    return _themePrefs.getBool(_themeKey);
  }
}
