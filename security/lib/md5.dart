import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart' as crypto;

String md5(String str) {
  Uint8List content = const Utf8Encoder().convert(str);
  crypto.Digest digest = crypto.md5.convert(content);
  String md5Str = digest.toString();
  return md5Str;
}
