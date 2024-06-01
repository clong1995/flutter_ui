import 'package:flutter/widgets.dart';

class Rpx {
  static double _width = 0;

  static init({double? width}) {
    if (width != null && width != 0) {
      _width = width;
    } else {
      _width = WidgetsBinding
          .instance.platformDispatcher.views.first.physicalSize.width;
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
