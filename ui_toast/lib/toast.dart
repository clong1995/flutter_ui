import 'package:flutter/material.dart';

Message? _message;
void Function(Message?)? _update;

class _Toast extends StatefulWidget {
  const _Toast();

  @override
  State<_Toast> createState() => _ToastState();
}

class _ToastState extends State<_Toast> {
  @override
  void initState() {
    super.initState();
    _update = (Message? message) {
      setState(() {
        _message = message;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return _message == null
        ? const SizedBox.shrink()
        : AbsorbPointer(
            absorbing: !_message!.choice,
            child: Container(
              color: _message!.choice?const Color(0x80000000):null,
              alignment: Alignment.center,
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  constraints: const BoxConstraints(
                    minWidth: 140,
                    minHeight: 60,
                  ),
                  decoration: BoxDecoration(
                    color: Color.lerp(_message!.color, Colors.white, .95),
                    border: Border.all(
                      color: _message!.color.withAlpha(2),
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
                          _message!.icon == Icons.sync
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: _message!.color,
                                  ),
                                )
                              : Icon(
                                  _message!.icon,
                                  color: _message!.color,
                                  size: 28,
                                ),
                          const SizedBox(width: 5),
                          Text(
                            _message!.text,
                            style: TextStyle(
                              color: _message!.color,
                              fontSize: 15,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                      if (_message!.choice) const SizedBox(height: 5),
                      if (_message!.choice)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: (){
                                _message!.callback(false);
                                _update?.call(null);
                              },
                              child: const Text("取消"),
                            ),
                            TextButton(
                              onPressed: () {
                                _message!.callback(true);
                                _update?.call(null);
                              },
                              child: const Text("确定"),
                            )
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

class Toast {
  static Message get success => Message()
    ..icon = Icons.check_circle_outline
    ..text = "成功"
    ..color = Colors.green;

  static Message get info => Message()
    ..icon = Icons.info_outline
    ..text = "提示"
    ..color = Colors.orange;

  static Message get failure => Message()
    ..icon = Icons.cancel_outlined
    ..text = "失败"
    ..color = Colors.red;

  static Message get loading => Message()
    ..icon = Icons.sync
    ..text = "加载中"
    ..color = Colors.blue
    ..autoClose = false;

  static Message get choice => Message()
    ..icon = Icons.help_outline
    ..text = "选择"
    ..color = Colors.blue
    ..autoClose = false
    ..choice = true;

  static void show(Message message) {
    message.text = message.text.trim();
    _update?.call(message);
    if (message.autoClose) {
      Future.delayed(const Duration(seconds: 1), () => _update?.call(null));
    }
  }

  static void dismiss() {
    _update?.call(null);
  }

  static Widget builder(BuildContext context, Widget? child) => Stack(
        children: [
          child ?? const SizedBox.shrink(),
          const Positioned.fill(
            child: _Toast(),
          ),
        ],
      );
}

typedef ChoiceBack = void Function(bool choice);

class Message {
  IconData icon = Icons.circle_outlined;
  String text = "无";
  Color color = Colors.grey;
  bool autoClose = true;
  bool choice = false;
  ChoiceBack callback = (bool choice){};
}
