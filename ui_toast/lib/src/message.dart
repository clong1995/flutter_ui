import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

class UiToastMessage {
  UiToastMessage();

  factory UiToastMessage.success() => UiToastMessage()
    ..icon = const Icon(
      Icons.check_circle_outline,
      color: Color(0xFF4CAF50),
    )
    ..text = '成功'
    ..color = const Color(0xFF4CAF50);

  factory UiToastMessage.info() => UiToastMessage()
    ..icon = const Icon(Icons.info_outline, color: Color(0xFFFF9800))
    ..text = '提示'
    ..color = const Color(0xFFFF9800);

  factory UiToastMessage.failure() => UiToastMessage()
    ..icon = const Icon(
      Icons.highlight_off,
      color: Color(0xFFF44336),
    )
    ..text = '失败'
    ..color = const Color(0xFFF44336);

  factory UiToastMessage.loading() => UiToastMessage()
    ..icon = const Icon(
      Icons.pending_outlined,
      color: Color(0xFF2196F3),
    )
    ..text = '加载中'
    ..color = const Color(0xFF2196F3)
    ..autoPopSeconds = -1;

  Widget icon = const Icon(Icons.circle);
  String text = '无';
  Color color = const Color(0xFF000000);
  int autoPopSeconds = 1; //0秒:永不关闭，-1:永不关闭但是等待大于等于5秒:将出关闭按钮

  //
  // ignore:avoid_positional_boolean_parameters
  void Function(bool value)? callback;
}
