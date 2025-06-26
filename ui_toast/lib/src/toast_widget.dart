//Message? _message;
import 'package:flutter/material.dart';

import '../ui_toast.dart' show UiToastMessage;

void Function(UiToastMessage?)? update;

class ToastWidget extends StatefulWidget {
  const ToastWidget({super.key});

  @override
  State<ToastWidget> createState() => ToastWidgetState();
}

class ToastWidgetState extends State<ToastWidget> {
  UiToastMessage? message;

  @override
  void initState() {
    super.initState();
    update = (UiToastMessage? meg) {
      setState(() {
        message = meg;
      });
    };
  }

  @override
  Widget build(BuildContext context) {
    return message == null
        ? const SizedBox.shrink()
        : AbsorbPointer(
      absorbing: message!.choiceCallback == null,
      child: Container(
        color:
        message!.choiceCallback != null
            ? const Color(0x80000000)
            : null,
        alignment: Alignment.center,
        child: IntrinsicWidth(
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(minWidth: 140, minHeight: 60),
            decoration: BoxDecoration(
              color: Color.lerp(message!.color, Colors.white, .95),
              border: Border.all(
                color: message!.color,
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
                    message!.icon,
                    const SizedBox(width: 5),
                    Text(
                      message!.text,
                      style: TextStyle(
                        color: message!.color,
                        fontSize: 15,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                if (message!.choiceCallback != null)
                  const SizedBox(height: 5),
                if (message!.choiceCallback != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          message!.choiceCallback!(false);
                          update?.call(null);
                        },
                        child: const Text("取消"),
                      ),
                      TextButton(
                        onPressed: () {
                          message!.choiceCallback!(true);
                          update?.call(null);
                        },
                        child: const Text("确定"),
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