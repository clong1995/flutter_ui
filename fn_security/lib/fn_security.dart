import 'package:fn_security/src/encrypt.dart' as src_encrypt;
import 'package:fn_security/src/md5.dart' as src_md5;

class FnSecurity {
  FnSecurity._();

  static Future<String> Function(String plainText) encrypter =
      src_encrypt.encrypter;

  static Future<String> Function(String encryptedText) decrypter =
      src_encrypt.decrypter;

  static String Function(String str) md5 = src_md5.md5;
}
