import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:js';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class Guid {
  static String _id = "";
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  static Future<String> get id async {
    if (_id.isNotEmpty) {
      return _id;
    }
    String input = "";
    if (kIsWeb) {
      await _injectJs();
      WebBrowserInfo webBrowserInfo = await _deviceInfo.webBrowserInfo;
      input =
          "${webBrowserInfo.appCodeName ?? ""}${webBrowserInfo.appName ?? ""}${webBrowserInfo.deviceMemory ?? 0}${webBrowserInfo.platform ?? ""}${webBrowserInfo.product ?? ""}${webBrowserInfo.userAgent ?? ""}${webBrowserInfo.vendor ?? ""}${webBrowserInfo.hardwareConcurrency ?? 0}";
      String result = context.callMethod("fingerprint");
      input+=result;
    }
    if (input.isEmpty) {
      throw "no guid";
    }
    input += defaultTargetPlatform.name;
    List<int> bytes = md5.convert(utf8.encode(input)).bytes;
    _id = base64.encode(bytes);
    return _id;
  }

  static Future<void> _injectJs() {
    Completer completer = Completer();
    Timer timer = Timer(const Duration(seconds: 3),
        () => completer.completeError('Failed to load script'));
    late ScriptElement script;
    String jsFnComplete = "c${_randomStr()}";
    String jsFnMd5 = "m${_randomStr()}";
    context[jsFnMd5] = (String str) {
      List<int> bytes = md5.convert(utf8.encode(str)).bytes;
      return base64.encode(bytes);
    };

    context[jsFnComplete] = () {
      timer.cancel();
      completer.complete();
      script.remove();
    };

    script = ScriptElement()
      ..type = 'text/javascript'
      ..text = '''
      window.$jsFnComplete();
      function fingerprint() {
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        ctx.textBaseline = "top";
        ctx.font = "14px 'Arial'";
        ctx.textBaseline = "alphabetic";
        ctx.fillStyle = "#f60";
        ctx.fillRect(125, 1, 62, 20);
        ctx.fillStyle = "#069";
        ctx.fillText("Hello, world!", 2, 15);
        ctx.fillStyle = "rgba(102, 204, 0, 0.7)";
        ctx.fillText("Hello, world!", 4, 17);
        ctx.globalCompositeOperation = "multiply";
        ctx.fillStyle = "rgb(255,0,255)";
        ctx.beginPath();
        ctx.arc(50, 50, 50, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.fill();
        ctx.fillStyle = "rgb(0,255,255)";
        ctx.beginPath();
        ctx.arc(100, 50, 50, 0, Math.PI * 2, true);
        ctx.closePath();
        ctx.fill();
        const dataURL = canvas.toDataURL();
        return window.$jsFnMd5(dataURL);
      }
      ''';
    document.body?.append(script);
    return completer.future;
  }

  static String _randomStr() {
    const String characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
        8, (index) => characters[Random().nextInt(characters.length)]).join();
  }
}
