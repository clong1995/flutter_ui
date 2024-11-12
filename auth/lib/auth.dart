import 'package:security/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _key = "__auth";

final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

String _ak = "";
String _sk = "";

class Auth {
  static String get ak => _ak;

  static String get sk => _sk;

  //从本地加载凭证
  static Future<bool> load() async {
    String? value = await _asyncPrefs.getString(_key);
    if (value == null) {
      return false;
    }
    String decryptText = await decrypter(value);
    List<String> arr = decryptText.split("-");
    _ak = arr[0];
    _sk = arr[1];
    return true;
  }

  //清除凭证
  static Future<void> clean() async {
    _ak = _sk = "";
    await _set();
  }

  //判断状态
  static bool state() => _ak != "" && _sk != "";

  static Future<void> _set() async {
    String encryptText = await encrypter("$_ak-$_sk");
    await _asyncPrefs.setString(_key, encryptText);
  }
}
