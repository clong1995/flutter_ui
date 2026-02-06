
import 'package:flutter/painting.dart';

class Config {
  static const double width = 200;
  static const TextStyle titleStyle = TextStyle(color: Color(0xFF616161));

  static const EdgeInsets titlePadding = EdgeInsets.zero;
  static const Color barrierColor = Color(0x80000000);
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets bottomPadding = EdgeInsets.only(bottom: 10);
  static const Decoration decoration = BoxDecoration(
    border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0))),
  );
}
