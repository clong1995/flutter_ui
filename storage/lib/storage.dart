import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  Future<void> setInt(String key, int value) async =>
      _asyncPrefs.setInt(key, value);

  Future<int?> getInt(String key) async => _asyncPrefs.getInt(key);

  Future<void> setString(String key, String value) async =>
      _asyncPrefs.setString(key, value);

  Future<String?> getString(String key) async => _asyncPrefs.getString(key);

  Future<void> setBool(String key, bool value) async =>
      _asyncPrefs.setBool(key, value);

  Future<bool?> getBool(String key) async => _asyncPrefs.getBool(key);

  Future<void> setDouble(String key, double value) async =>
      _asyncPrefs.setDouble(key, value);

  Future<double?> getDouble(String key) async => _asyncPrefs.getDouble(key);

  Future<void> setStringList(String key, List<String> value) async =>
      _asyncPrefs.setStringList(key, value);

  Future<List<String>?> getStringList(String key) async =>
      _asyncPrefs.getStringList(key);

  Future<void> remove(String key) async => _asyncPrefs.remove(key);

  Future<bool> containsKey(String key) async => _asyncPrefs.containsKey(key);
}
