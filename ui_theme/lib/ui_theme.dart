import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

class UiTheme {
  static Color primaryColor = const Color(0xFF5681F6);

  //fontSize
  static double fontSize = 13.r;
  static String? fontFamily;

  //grey
  static const Color grey = Color(0xFF9E9E9E);
  static const Color grey50 = Color(0xFFFAFAFA);
  static const Color grey100 = Color(0xFFF5F5F5);
  static const Color grey200 = Color(0xFFEEEEEE);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color grey350 = Color(0xFFD6D6D6);
  static const Color grey400 = Color(0xFFBDBDBD);
  static const Color grey500 = grey;
  static const Color grey600 = Color(0xFF757575);
  static const Color grey700 = Color(0xFF616161);
  static const Color grey800 = Color(0xFF424242);
  static const Color grey850 = Color(0xFF303030);
  static const Color grey900 = Color(0xFF212121);

  //transparent
  static const Color transparent = Color(0x00000000);

  //white
  static const Color white = Color(0xFFFFFFFF);
  //white
  static const Color black = Color(0xFF000000);
  //green
  static const Color green = Color(0xFF4CAF50);
}
