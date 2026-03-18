import 'package:shared_preferences/shared_preferences.dart';

class FnStorage {
  FnStorage._();

  static final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  static Future<void> setInt(String key, int value) =>
      _asyncPrefs.setInt(key, value);

  static Future<int?> getInt(String key) => _asyncPrefs.getInt(key);

  static Future<void> setString(String key, String value) =>
      _asyncPrefs.setString(key, value);

  static Future<String?> getString(String key) => _asyncPrefs.getString(key);

  static Future<void> setBool(String key, bool value) =>
      _asyncPrefs.setBool(key, value);

  static Future<bool?> getBool(String key) => _asyncPrefs.getBool(key);

  static Future<void> setDouble(String key, double value) =>
      _asyncPrefs.setDouble(key, value);

  static Future<double?> getDouble(String key) => _asyncPrefs.getDouble(key);

  static Future<void> setStringList(String key, List<String> value) =>
      _asyncPrefs.setStringList(key, value);

  static Future<List<String>?> getStringList(String key) =>
      _asyncPrefs.getStringList(key);

  static Future<void> remove(String key) => _asyncPrefs.remove(key);

  static Future<bool> containsKey(String key) => _asyncPrefs.containsKey(key);
}
