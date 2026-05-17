import 'dart:ui';

import 'package:flutter/widgets.dart';

class Height {
  // 私有构造函数防止实例化
  Height._();

  // 获取当前唯一的 FlutterView
  static FlutterView get _view => WidgetsBinding.instance.platformDispatcher.views.first;

  // 获取状态栏高度（顶部安全区域）
  static double get statusBarHeight {
    return _view.viewPadding.top / _view.devicePixelRatio;
  }

  // 获取底部安全区域高度（用于避开手势条等）
  static double get bottomSafeHeight {
    return _view.viewPadding.bottom / _view.devicePixelRatio;
  }

  // 获取设备像素比
  static double get pixelRatio => _view.devicePixelRatio;
}