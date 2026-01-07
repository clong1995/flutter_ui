import 'dart:math';

import 'package:flutter/foundation.dart';

class Rpx {
  Rpx._();

  static double _width = 0;

  static void init([double? width]) {
    if (width != null) {
      _width = width;
      return;
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        //固定窗口大小建议传入width
        //非固定窗口，建议传入初始化窗口的width，并设置最小窗口尺寸。
        //网页也能检测到走到这个分支，建议传入width，设置网页最小尺寸
        if (kDebugMode) {
          //网页开发可能在桌面端，继续走适配逻辑
          break;
        }
        return;
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.fuchsia:
        // 移动端平台，不执行任何操作
        break;
    }
    final flutterView = PlatformDispatcher.instance.views.first;
    final pw = flutterView.physicalSize.width;
    final ph = flutterView.physicalSize.height;
    _width = min(pw, ph) / flutterView.devicePixelRatio;
  }

  static double rpx(double size) {
    if (size == 0) {
      return 0;
    }
    if (_width == 0) {
      return size;
    }
    return _width / 375 * size;
  }
}
