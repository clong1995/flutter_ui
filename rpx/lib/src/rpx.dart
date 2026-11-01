import 'dart:math';

import 'package:flutter/foundation.dart';

double? _width;

void setWidth([double? width]) {
  if (_width != null) {
    return;
  }

  if (width != null) {
    _width = width;
    return;
  }

  final display = PlatformDispatcher.instance.views.first.display;
  final pixelRatio = display.devicePixelRatio;

  _width = display.size.shortestSide / pixelRatio;
}

double rpx(double size) {
  if (size == 0) {
    return 0;
  }

  if (_width == null) {
    setWidth();
  }

  if (_width == 0) {
    return size;
  }

  return _width! / 375 * size;
}
