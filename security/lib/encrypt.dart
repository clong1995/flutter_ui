import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:guid/guid.dart';

Future<String> encrypter(String plainText) async {
  encrypt.IV iv = encrypt.IV.fromLength(16);
  encrypt.Encrypter encrypter = await _encrypter();
  encrypt.Encrypted encrypted = encrypter.encrypt(plainText, iv: iv);
  return "${iv.base64}:${encrypted.base64}";
}

Future<String> decrypter(String encryptedText) async {
  List<String> parts = encryptedText.split(":");
  if (parts.length != 2) {
    return "";
  }
  encrypt.IV iv = encrypt.IV.fromBase64(parts[0]);
  encryptedText = parts[1];

  encrypt.Encrypter encrypter = await _encrypter();
  String decrypted = "";
  try{
    decrypted = encrypter.decrypt64(encryptedText, iv: iv);
  }catch(e){
    if (kDebugMode) {
      print(e);
    }
    return "";
  }
  return decrypted;
}

Future<encrypt.Encrypter> _encrypter() async {
  String deviceId = await Guid.id;
  deviceId = deviceId.length > 32
      ? deviceId.substring(0, 32)
      : deviceId.padRight(32, ' ');
  encrypt.Key key = encrypt.Key.fromUtf8(deviceId);
  return encrypt.Encrypter(encrypt.AES(key));
}
