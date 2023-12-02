import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences _userPrefs;

  static const _displayNameKey = 'username';

  static Future init() async =>
      _userPrefs = await SharedPreferences.getInstance();

  static Future saveUserName(String displayName) async {
    await _userPrefs.setString(_displayNameKey, displayName);
  }

  static String? getUserName() => _userPrefs.getString(_displayNameKey);
}
