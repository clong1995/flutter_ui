import 'dart:io';
import 'dart:math';
import 'dart:ui';

class Rpx {
  static double _width = 0;

  static init([double? width]) {
    if (Platform.isMacOS || Platform.isLinux || Platform.isWindows) {
      return;
    }

    if (width != null) {
      _width = width;
    } else {
      FlutterView flutterView = PlatformDispatcher.instance.views.first;
      double pw = flutterView.physicalSize.width;
      double ph = flutterView.physicalSize.height;
      _width = min(pw, ph) / flutterView.devicePixelRatio;
    }
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
