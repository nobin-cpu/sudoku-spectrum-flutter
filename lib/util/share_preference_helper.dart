
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper{

  static const String accessTokenKey                = 'access_token';
  static const String removeBgCountKey                = 'remove_bg_count';
    static const String uid               = 'user_uid';
  static const String accessTokenType               = 'access_type';
  static Future<void> setIsFirstTimeUser(bool isFirstTime) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTimeUser', isFirstTime);
  }

  // Method to get isFirstTimeUser from shared preferences.
  static Future<bool> getIsFirstTimeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFirstTimeUser') ?? true;
  }

}