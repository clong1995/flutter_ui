import 'package:flutter/material.dart';

class Rpx {
  static double _width = 0;

  static init(){
    _width =  WidgetsBinding.instance.platformDispatcher.views.first.physicalSize.width;
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
