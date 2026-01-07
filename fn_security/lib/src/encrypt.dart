import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:fn_device/fn_device.dart';

Future<String> encrypter(String plainText) async {
  final iv = encrypt.IV.fromLength(16);
  final encrypter = await _encrypter();
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return '${iv.base64}:${encrypted.base64}';
}

Future<String> decrypter(String encryptedText) async {
  final parts = encryptedText.split(':');
  if (parts.length != 2) {
    return '';
  }
  final iv = encrypt.IV.fromBase64(parts[0]);
  final eText = parts[1];

  final encrypter = await _encrypter();
  var decrypted = '';
  try{
    decrypted = encrypter.decrypt64(eText, iv: iv);
  }on Exception catch(e){
    if (kDebugMode) {
      print(e);
    }
    return '';
  }
  return decrypted;
}

Future<encrypt.Encrypter> _encrypter() async {
  var deviceId = await FnDevice.guid;
  deviceId = deviceId.length > 32
      ? deviceId.substring(0, 32)
      : deviceId.padRight(32);
  final key = encrypt.Key.fromUtf8(deviceId);
  return encrypt.Encrypter(encrypt.AES(key));
}
