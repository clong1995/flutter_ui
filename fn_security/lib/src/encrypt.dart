import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:fn_device/fn_device.dart';
import 'package:logger/logger.dart';
import 'package:pointycastle/export.dart';

/// 加密：返回 Base64(IV + 密文)
Future<String> encrypter(String plainText) async {
  try {
    final key = await _getDeviceKey();
    // GCM 推荐使用 12 字节（96位）的 IV
    final iv = _generateSecureRandom(12);

    final cipher = GCMBlockCipher(AESEngine())
      ..init(true, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));

    final input = Uint8List.fromList(utf8.encode(plainText));
    final encrypted = cipher.process(input);

    // --- 修改点：拼接字节后再编码 ---
    final len = iv.length + encrypted.length;
    final combined = Uint8List(len)
    ..setRange(0, iv.length, iv)
    ..setRange(iv.length, len, encrypted);

    return base64.encode(combined);
  } catch (e) {
    logger(e.toString());
    return '';
  }
}

/// 解密：输入 Base64(IV + 密文)
Future<String> decrypter(String encryptedText) async {
  try {
    // --- 修改点：先解码 Base64，再按长度截取 ---
    final combined = base64.decode(encryptedText);
    const ivLength = 12; // 与加密时保持一致

    if (combined.length < ivLength) {
      return '';
    }

    final iv = combined.sublist(0, ivLength);
    final cipherText = combined.sublist(ivLength);

    final key = await _getDeviceKey();
    final cipher = GCMBlockCipher(AESEngine())
      ..init(false, AEADParameters(KeyParameter(key), 128, iv, Uint8List(0)));

    final decrypted = cipher.process(cipherText);
    return utf8.decode(decrypted);
  } catch (e) {
    logger(e.toString());
    return '';
  }
}

// 辅助函数保持不变...
Future<Uint8List> _getDeviceKey() async {
  String deviceId = await FnDevice.guid;
  if (deviceId.length > 32) {
    deviceId = deviceId.substring(0, 32);
  } else {
    deviceId = deviceId.padRight(32, '0');
  }
  return Uint8List.fromList(utf8.encode(deviceId));
}

Uint8List _generateSecureRandom(int length) {
  final secureRandom = Random.secure();
  return Uint8List.fromList(
    List<int>.generate(length, (i) => secureRandom.nextInt(256)),
  );
}
