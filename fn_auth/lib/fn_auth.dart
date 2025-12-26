import 'package:security/encrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FnAuth {
  FnAuth._();

  static String _ak = '';
  static String _sk = '';
  static List<String> _role = [];

  static final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();

  static const String _key = '__auth';

  static String get ak => _ak;

  static String get sk => _sk;


  //
  // ignore:avoid_setters_without_getters
  static set role(List<String> r) => _role = r;


  static bool roleAllow(List<String> role) =>
      role.any((element) => _role.contains(element));

  //载入凭证
  static Future<void> load({
    String? ak,
    String? sk,
    bool persist = true,
  }) async {
    //从外部参数载入
    if (ak != null && sk != null && ak != '' && sk != '') {
      _ak = ak;
      _sk = sk;
      if (persist) {
        final encryptText = await encrypter('$_ak:$_sk');
        await _asyncPrefs.setString(_key, encryptText);
      }
      return;
    }

    //从storage载入
    final value = await _asyncPrefs.getString(_key);
    if (value == null || value.isEmpty) {
      return;
    }

    final decryptText = await decrypter(value);
    final arr = decryptText.split(':');
    if (arr.length != 2) {
      return;
    }
    _ak = arr[0];
    _sk = arr[1];
    return;
  }

  //清除凭证
  static Future<void> clean() async {
    _ak = _sk = '';
    await _asyncPrefs.setString(_key, '');
  }

  //判断状态
  static bool get state => _ak != '' && _sk != '';

}






