import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';

class MultiWindow {
  static Future<void> ensureInitialized(int port) async {
    await windowManager.ensureInitialized();
    bool newSession = true;
    if (defaultTargetPlatform == TargetPlatform.windows) {
      ProcessResult result = await Process.run(
          'powershell', ['-Command', 'netstat -aon | findstr $port']);
      if (result.stdout.isNotEmpty) {
        newSession = false;
      } else {
        RawDatagramSocket socket =
        await RawDatagramSocket.bind(InternetAddress.loopbackIPv4, port);
        socket.listen((event) {});
      }
    } else {
      try {
        RawDatagramSocket socket =
        await RawDatagramSocket.bind(InternetAddress.loopbackIPv4, port);
        socket.listen((event) {});
      } catch (e) {
        newSession = false;
      }
    }
    if (newSession) {
      //原来窗口
      await _Storage.clean();
    } else {
      //新窗口
      String? max = await _Storage.get("max");
      if (max == "true") {
        windowManager.maximize();
      } else {
        String? size = await _Storage.get("size");
        if (size != null) {
          List<String> arr = size.split(",");
          if (arr.length == 2) {
            double? width = double.tryParse(arr[0]);
            double? height = double.tryParse(arr[1]);
            if (width != null && height != null) {
              await windowManager.setSize(Size(width, height));
              await windowManager.center();
            }
          }
        }
      }
    }
  }

  static Future<void> open({
    String? args,
    Size? size,
    bool? max,
  }) async {
    await _Storage.clean();
    if (args != null) {
      await _Storage.set("args", args);
    }
    if (max == null) {
      if (size != null) {
        await _Storage.set("size", "${size.width},${size.height}");
      }
    } else if (max == true) {
      await _Storage.set("max", "true");
    }
    String exePath = Platform.resolvedExecutable;
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await Process.start(
        'open',
        ['-n', '-a', exePath],
      );
    } else {
      await Process.start(exePath, []);
    }
  }

  static Future<String?> get args async {
    return await _Storage.get("args");
  }
}

class _Storage {
  static Future<String?> get(String key) async => await _storage("get", key);

  static Future<void> set(String key, String value) async =>
      await _storage("set", key, value);

  static Future<void> clean() async => await _storage("clean");

  static Future<String?> _storage(String opt,
      [String? key, dynamic value]) async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File tempFile = File(join(tempPath, ".multi_window"));

    bool fileExists = await tempFile.exists();

    if (!fileExists) {
      await tempFile.create();
      tempFile = File(join(tempPath, ".multi_window"));
      String jsonString = jsonEncode({
        'args': null,
        'size': null,
        'max': null,
      });
      await tempFile.writeAsString(jsonString);
    }
    String contents = await tempFile.readAsString();
    Map<String, dynamic>? content = jsonDecode(contents);
    if (content == null) {
      return null;
    }
    if (opt == "set") {
      if (key != null) {
        content[key] = value;
        String jsonString = jsonEncode(content);
        await tempFile.writeAsString(jsonString);
      }
    } else if (opt == "get") {
      return content[key];
    } else if (opt == "clean") {
      String jsonString = jsonEncode({
        'args': null,
        'size': null,
        'max': null,
      });
      await tempFile.writeAsString(jsonString);
    }
    return null;
  }
}
