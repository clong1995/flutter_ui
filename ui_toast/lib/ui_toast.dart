import 'dart:async';

import 'package:flutter/material.dart';

/*import 'package:ui_toast/src/toast_widget.dart';

class UiToast {
  static UiToastMessage get success => UiToastMessage()
    ..icon = const Icon(Icons.check_circle_outline, color: Colors.green)
    ..text = '成功'
    ..color = Colors.green;

  static UiToastMessage get info => UiToastMessage()
    ..icon = const Icon(Icons.info_outline, color: Colors.orange)
    ..text = '提示'
    ..color = Colors.orange;

  static UiToastMessage get failure => UiToastMessage()
    ..icon = const Icon(Icons.cancel_outlined, color: Colors.red)
    ..text = '失败'
    ..color = Colors.red;

  static UiToastMessage get loading => UiToastMessage()
    ..icon = const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(color: Colors.blue),
    )
    ..text = '加载中'
    ..color = Colors.blue
    ..autoClose = false;

  static UiToastMessage get choice => UiToastMessage()
    ..icon = const Icon(Icons.help_outline, color: Colors.blue)
    ..text = '选择'
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
  String text = '无';
  Color color = Colors.grey;
  bool autoClose = true;
  void Function(bool choice)? choiceCallback;
}*/

class UiToast {
  UiToast._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  static void init({
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    _navigatorKey = navigatorKey;
  }

  static OverlayEntry? _entry;
  static Timer? _timer;

  static void show(UiToastMessage message) {
    final overlay = _navigatorKey?.currentState?.overlay;
    if (overlay == null) {
      return;
    }

    dismiss();

    _entry = OverlayEntry(
      builder: (_) => _ToastWidget(message: message),
    );

    overlay.insert(_entry!);

    if (!message.autoClose || message.choiceCallback != null) {
      return;
    }

    _timer = Timer(const Duration(seconds: 1), dismiss);
  }

  static void dismiss() {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;
  }
}

class UiToastMessage {
  UiToastMessage();

  factory UiToastMessage.success() => UiToastMessage()
    ..icon = const Icon(Icons.check_circle_outline, color: Colors.green)
    ..text = '成功'
    ..color = Colors.green;

  factory UiToastMessage.info() => UiToastMessage()
    ..icon = const Icon(Icons.info_outline, color: Colors.orange)
    ..text = '提示'
    ..color = Colors.orange;

  factory UiToastMessage.failure() => UiToastMessage()
    ..icon = const Icon(Icons.cancel_outlined, color: Colors.red)
    ..text = '失败'
    ..color = Colors.red;

  factory UiToastMessage.loading() => UiToastMessage()
    ..icon = const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(color: Colors.blue),
    )
    ..text = '加载中'
    ..color = Colors.blue
    ..autoClose = false;

  Widget icon = const Icon(Icons.circle_outlined);
  String text = '无';
  Color color = const Color(0xFF000000);
  bool autoClose = true;
  void Function(bool choice)? choiceCallback;
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({required this.message});

  final UiToastMessage message;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: widget.message.choiceCallback == null,
      child: Container(
        color: widget.message.choiceCallback != null
            ? const Color(0x80000000)
            : null,
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(
              minWidth: 140,
              minHeight: 60,
            ),
            decoration: BoxDecoration(
              color: Color.lerp(widget.message.color, Colors.white, .95),
              border: Border.all(
                color: widget.message.color,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.message.icon,
                    const SizedBox(width: 5),
                    Text(
                      widget.message.text,
                      style: TextStyle(
                        color: widget.message.color,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                if (widget.message.choiceCallback != null)
                  const SizedBox(height: 10),
                if (widget.message.choiceCallback != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          widget.message.choiceCallback!(false);
                          UiToast.dismiss();
                        },
                        child: const Text('取消'),
                      ),
                      TextButton(
                        onPressed: () {
                          widget.message.choiceCallback!(true);
                          UiToast.dismiss();
                        },
                        child: const Text('确定'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
