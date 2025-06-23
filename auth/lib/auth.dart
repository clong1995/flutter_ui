import 'package:security/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _key = "__auth";

final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

String _ak = "";
String _sk = "";
List<String> _role = [];

class Auth {
  static String get ak => _ak;

  static String get sk => _sk;

  //加载凭证
  static Future<void> load({
    String? ak,
    String? sk,
    bool persist = true,
  }) async {
    if (ak != null && sk != null && ak != "" && sk != "") {
      _ak = ak;
      _sk = sk;
      if (persist) {
        await _set();
      }
      return;
    }

    String? value = await _asyncPrefs.getString(_key);
    if (value == null || value.isEmpty) {
      return;
    }

    String decryptText = await decrypter(value);
    List<String> arr = decryptText.split(":");
    if (arr.length != 2) {
      return;
    }
    _ak = arr[0];
    _sk = arr[1];
    return;
  }

  //清除凭证
  static Future<void> clean() async {
    _ak = _sk = "";
    await _asyncPrefs.setString(_key, "");
  }

  //判断状态
  static bool state() => _ak != "" && _sk != "";

  static bool allow(List<String> role) => role.any((element) => _role.contains(element));

  static set role(List<String> r) => _role = r;
}

Future<void> _set() async {
  String encryptText = await encrypter("$_ak:$_sk");
  await _asyncPrefs.setString(_key, encryptText);
}
