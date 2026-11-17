import 'dart:convert';
import 'package:crypto/crypto.dart';

String hmacSha256(String data, String key) {
  final hmac = Hmac(sha256, utf8.encode(key));
  final digest = hmac.convert(utf8.encode(data));

  return digest.toString();
}