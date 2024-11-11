import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:guid/guid.dart';


Future<String> encryptText(String plainText) async {
  final iv = encrypt.IV.fromLength(16);
  final encrypter = await _encrypter();
  final encrypted = encrypter.encrypt(plainText, iv: iv);
  return "${iv.base64}:${encrypted.base64}";
}

Future<String> decryptText(String encryptedText) async {
  final parts = encryptedText.split(":");
  if (parts.length != 2) {
    return "";
  }
  final iv = encrypt.IV.fromBase64(parts[0]);
  encryptedText = parts[1];

  final encrypter = await _encrypter();
  final decrypted = encrypter.decrypt64(encryptedText, iv: iv);
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
