import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences sf;
  static Future<SharedPreferences> getInstance() async {
    return sf ?? await SharedPreferences.getInstance();
  }

  static Future<bool> setString(String key, {String value = ""}) async {
    await getInstance();
    return sf.setString(key, value ?? "");
  }

  static Future<String> getString(String key) async {
    await getInstance();
    return sf.getString(key) ?? "";
  }

  static Future<bool> setInt(String key, {int value = 0}) async {
    await getInstance();
    return await sf.setInt(key, value);
  }

  static Future<int> getInt(String key) async {
    await getInstance();
    return sf.getInt(key);
  }

  static Future<bool> setBool(String key, {bool value = false}) async {
    await getInstance();
    return await sf.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    await getInstance();
    return sf.getBool(key);
  }
}
