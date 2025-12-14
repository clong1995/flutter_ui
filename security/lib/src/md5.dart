import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

String md5(String str) {
  final content = const Utf8Encoder().convert(str);
  final digest = crypto.md5.convert(content);
  final md5Str = digest.toString();
  return md5Str;
}
