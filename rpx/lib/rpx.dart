import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';

class Rpx {
  static double _width = 0;

  static init([double? width]) {
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
        return;
      default:
        break;
    }
    FlutterView flutterView = PlatformDispatcher.instance.views.first;
    double pw = flutterView.physicalSize.width;
    double ph = flutterView.physicalSize.height;
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
