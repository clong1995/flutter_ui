import 'dart:ui';

class Rpx {
  static double _width = 0;

  static init([double? width]) {
    if (width != null) {
      _width = width;
    } else {
      FlutterView flutterView = PlatformDispatcher.instance.views.first;
      _width = flutterView.physicalSize.width / flutterView.devicePixelRatio;
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
