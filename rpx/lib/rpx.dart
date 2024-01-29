import 'dart:io';

import 'package:flutter/material.dart';

class Rpx {
  static double _width = 0;

  //当theme中就要配置
  static void init(
    BuildContext context,
  ) {
    _setWidth(MediaQuery.of(context).size.width);
  }

  static Widget builder(BuildContext context, Widget child) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    _setWidth(mediaQueryData.size.width);
    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaleFactor: 1,
      ),
      child: child,
    );
  }

  static double rpx(double size) {
    if (_width == 0) {
      return size;
    }
    return _width / 375 * size;
  }

  static void _setWidth(double width) {
    if (Platform.isWindows || Platform.isMacOS) {
      _width = 375;
    }else{
      _width = width;
    }
  }
}
