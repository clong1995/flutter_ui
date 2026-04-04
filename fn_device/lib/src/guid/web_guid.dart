import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

class Guid {
  static String _id = '';
  static Future<String>? _idFuture;
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// 获取设备唯一标识 ID (MD5 散列并格式化)
  static Future<String> get id => _idFuture ??= _generateId();

  static Future<String> _generateId() async {
    if (_id.isNotEmpty) {
      return _id;
    }
    final infoString = await info;
    final md5Hash = _md5(infoString);
    final buffer = StringBuffer();
    for (var i = 0; i < md5Hash.length; i++) {
      buffer.write(md5Hash[i]);
      if ((i + 1) % 4 == 0 && i != md5Hash.length - 1) {
        buffer.write('-');
      }
    }
    return _id = buffer.toString();
  }

  static Future<String> get info async {
    if (!kIsWeb) {
      return defaultTargetPlatform.name;
    }

    final webBrowserInfo = await _deviceInfo.webBrowserInfo;
    final canvasFingerprint = _getCanvasFingerprint();

    final buffer = StringBuffer()
      ..write(
        '${webBrowserInfo.appCodeName ?? ''}'
        '${webBrowserInfo.appName ?? ''}'
        '${webBrowserInfo.deviceMemory ?? 0}'
        '${webBrowserInfo.platform ?? ''}'
        '${webBrowserInfo.product ?? ''}'
        '${webBrowserInfo.userAgent ?? ''}'
        '${webBrowserInfo.vendor ?? ''}'
        '${webBrowserInfo.hardwareConcurrency ?? 0}'
        '${_md5(canvasFingerprint)}'
        '${web.window.navigator.language}'
        '${defaultTargetPlatform.name}',
      );

    return buffer.toString();
  }

  // 直接在 Dart 侧进行 Canvas 指纹计算
  static String _getCanvasFingerprint() {
    try {
      final canvas =
          web.document.createElement('canvas') as web.HTMLCanvasElement
            ..width = 240
            ..height = 60;
      final ctx = canvas.getContext('2d') as web.CanvasRenderingContext2D?;
      if (ctx == null) return '';

      ctx
        ..textBaseline = 'top'
        ..font = '14px Arial'
        ..textBaseline = 'alphabetic'
        ..fillStyle = '#f60'.toJS
        ..fillRect(125, 1, 62, 20)
        ..fillStyle = '#069'.toJS
        ..fillText('Hello, world!', 2, 15)
        ..fillStyle = 'rgba(102, 204, 0, 0.7)'.toJS
        ..fillText('Hello, world!', 4, 17)
        ..globalCompositeOperation = 'multiply'
        ..fillStyle = 'rgb(255,0,255)'.toJS
        ..beginPath()
        ..arc(50, 50, 50, 0, pi * 2, true)
        ..closePath()
        ..fill()
        ..fillStyle = 'rgb(0,255,255)'.toJS
        ..beginPath()
        ..arc(100, 50, 50, 0, pi * 2, true)
        ..closePath()
        ..fill();
      return canvas.toDataURL();
    } on Exception catch (_) {
      return '';
    }
  }

  static String _md5(String str) {
    if (str.isEmpty) return '';
    final bytes = utf8.encode(str);
    return md5.convert(bytes).toString();
  }
}
