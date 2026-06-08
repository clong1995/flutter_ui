import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

class UiToastMessage {
  UiToastMessage();

  factory UiToastMessage.success() => UiToastMessage()
    ..icon = Icons.check_circle_outline
    ..text = '成功'
    ..color = const Color(0xFF4CAF50);

  factory UiToastMessage.info() => UiToastMessage()
    ..icon = Icons.info_outline
    ..text = '提示'
    ..color = const Color(0xFFFF9800);

  factory UiToastMessage.failure() => UiToastMessage()
    ..icon = Icons.highlight_off
    ..text = '失败'
    ..color = const Color(0xFFF44336);

  /*factory UiToastMessage.loading() => UiToastMessage()
    ..icon = const Icon(
      Icons.pending_outlined,
      color: Color(0xFF2196F3),
    )
    ..text = '加载中'
    ..color = const Color(0xFF2196F3)
    ..autoPopSeconds = -1;*/

  IconData icon = Icons.circle;
  String text = '无';
  Color color = const Color(0xFF000000);
  int autoPopSeconds = 1; //自动关闭的时间
  bool select = false;

  //
  // ignore:avoid_positional_boolean_parameters
  //void Function(bool value)? callback;
}
