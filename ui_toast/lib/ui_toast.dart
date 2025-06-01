import 'package:flutter/material.dart';

import 'src/toast.dart';

class UiToast {
  static UiToastMessage get success =>
      UiToastMessage()
        ..icon = const Icon(Icons.check_circle_outline, color: Colors.green)
        ..text = "成功"
        ..color = Colors.green;

  static UiToastMessage get info =>
      UiToastMessage()
        ..icon = const Icon(Icons.info_outline, color: Colors.orange)
        ..text = "提示"
        ..color = Colors.orange;

  static UiToastMessage get failure =>
      UiToastMessage()
        ..icon = const Icon(Icons.cancel_outlined, color: Colors.red)
        ..text = "失败"
        ..color = Colors.red;

  static UiToastMessage get loading =>
      UiToastMessage()
        ..icon = const SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(color: Colors.blue),
        )
        ..text = "加载中"
        ..color = Colors.blue
        ..autoClose = false;

  static UiToastMessage get choice =>
      UiToastMessage()
        ..icon = const Icon(Icons.help_outline, color: Colors.blue)
        ..text = "选择"
        ..color = Colors.blue
        ..autoClose = false
        ..choiceCallback = (bool choice) {};

  static void show(UiToastMessage message) {
    if (update == null) {
      return;
    }
    message.text = message.text.trim();
    update!.call(message);
    if (message.autoClose) {
      Future.delayed(const Duration(seconds: 1), () => update!.call(null));
    }
  }

  static void dismiss() => update?.call(null);
}

Widget uiToastBuilder(BuildContext context, Widget? child) => Stack(
  children: [
    child ?? const SizedBox.shrink(),
    const Positioned.fill(child: ToastWidget()),
  ],
);

class UiToastMessage {
  Widget icon = const Icon(Icons.circle_outlined);
  String text = "无";
  Color color = Colors.grey;
  bool autoClose = true;
  void Function(bool choice)? choiceCallback;
}
