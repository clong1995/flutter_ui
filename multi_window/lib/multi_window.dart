import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

class MultiWindow {
  static Future<String> ensureInitialized(List<String> args) async {
    await windowManager.ensureInitialized();
    String argsStr = "";
    String sizeStr = "";
    for (String arg in args) {
      if (arg.startsWith('--arg=')) {
        argsStr = arg.split('=')[1];
      } else if (arg.startsWith('--size=')) {
        sizeStr = arg.split('=')[1];
      }
    }

    //大小
    Size size = const Size(1280, 720);
    if (sizeStr.isNotEmpty) {
      List<String> arr = sizeStr.split(",");
      if (arr.length == 2) {
        double? width = double.tryParse(arr[0]);
        double? height = double.tryParse(arr[1]);
        if (width != null && height != null) {
          size = Size(width, height);
        }
      }
    }
    if (size.width == 0 || size.height == 0) {
      await windowManager.maximize();
    } else {
      await windowManager.setSize(size);
      await windowManager.center();
    }
    return argsStr;
  }

  static Future<void> open({
    String? arg,
    Size? size,
  }) async {
    String exePath = Platform.resolvedExecutable;
    String argSize = "";
    if (size != null) {
      argSize = "${size.width},${size.height}";
    }
    List<String> args = [
      '--arg=${arg ?? ""}',
      '--size=$argSize',
    ];
    if (defaultTargetPlatform == TargetPlatform.macOS) {
      await Process.start(
        'open',
         ['-n','-a', exePath, '--args',...args],
      );
    } else {
      await Process.start(exePath, args);
    }
  }
}
