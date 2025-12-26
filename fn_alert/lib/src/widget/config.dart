import 'package:flutter/material.dart';

class Config {
  static const double width = 200;
  static final TextStyle titleStyle = TextStyle(color: Colors.grey.shade700);

  static const EdgeInsets titlePadding = EdgeInsets.zero;
  static const Color barrierColor = Color(0x80000000);
  static const EdgeInsets contentPadding = EdgeInsets.symmetric(horizontal: 10);
  static const EdgeInsets bottomPadding = EdgeInsets.only(bottom: 10);
  static final Decoration decoration = BoxDecoration(
    border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
  );
}
