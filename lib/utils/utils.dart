import 'package:shared_preferences/shared_preferences.dart';

class Utils{
  static Future<void> setSharedPrefValueJson(String json,String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(json, value);
  }
  static Future<String?> getSharedPrefValueJson(String json) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(json);
  }
}