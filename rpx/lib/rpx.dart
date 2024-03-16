import 'dart:io';

import 'package:flutter/material.dart';

class Rpx {
  static double _width = 0;

  //当theme中就要配置
  static void init(
    BuildContext context,
  ) {
    _setWidth(MediaQuery.of(context));
  }

  static Widget builder(BuildContext context, Widget child) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    _setWidth(mediaQueryData);
    return MediaQuery(
      data: mediaQueryData.copyWith(
        textScaler: const TextScaler.linear(1),
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

  static void _setWidth(MediaQueryData mediaQueryData) {
    if (Platform.isWindows || Platform.isMacOS) {
      _width = 375;
    }else{
      Orientation orientation = mediaQueryData.orientation;
      if(orientation == Orientation.landscape){
        _width = mediaQueryData.size.height;
      }else{
        _width = mediaQueryData.size.width;
      }
    }
  }
}
