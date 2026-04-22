import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:fn_device/fn_device.dart';
import 'package:logger/logger.dart';
import 'package:pointycastle/export.dart';


/// 加密：返回 "IV的Base64:密文的Base64"
Future<String> encrypter(String plainText) async {
  try {
    final key = await _getDeviceKey();
    // GCM 推荐使用 12 字节（96位）的 IV
    final iv = _generateSecureRandom(12);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(true, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));

    final input = Uint8List.fromList(utf8.encode(plainText));
    final encrypted = cipher.process(input);

    return '${base64.encode(iv)}:${base64.encode(encrypted)}';
  } catch (e) {
    logger(e.toString());
    return '';
  }
}

/// 解密：输入 "IV的Base64:密文的Base64"
Future<String> decrypter(String encryptedText) async {
  final parts = encryptedText.split(':');
  if (parts.length != 2) return '';

  try {
    final key = await _getDeviceKey();
    final iv = base64.decode(parts[0]);
    final cipherText = base64.decode(parts[1]);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(false, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));

    final decrypted = cipher.process(cipherText);
    return utf8.decode(decrypted);
  } catch (e) {
    logger(e.toString());
    return '';
  }
}

/// 辅助：获取基于 DeviceID 的 32 字节 Key (AES-256)
Future<Uint8List> _getDeviceKey() async {
  String deviceId = await FnDevice.guid;
  // 确保长度为 32 字节（用于 AES-256）
  if (deviceId.length > 32) {
    deviceId = deviceId.substring(0, 32);
  } else {
    deviceId = deviceId.padRight(32, '0');
  }
  return Uint8List.fromList(utf8.encode(deviceId));
}

/// 辅助：生成安全随机数 IV
Uint8List _generateSecureRandom(int length) {
  final secureRandom = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (i) => secureRandom.nextInt(256)),
  );
}
