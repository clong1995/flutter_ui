import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';

class UiToast {
  UiToast._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
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
    ..icon = const FaIcon(
      FontAwesomeIcons.circleCheck,
      color: Color(0xFF4CAF50),
    )
    ..text = '成功'
    ..color = const Color(0xFF4CAF50);

  factory UiToastMessage.info() => UiToastMessage()
    ..icon = const FaIcon(FontAwesomeIcons.circleDot, color: Color(0xFFFF9800))
    ..text = '提示'
    ..color = const Color(0xFFFF9800);

  factory UiToastMessage.failure() => UiToastMessage()
    ..icon = const FaIcon(
      FontAwesomeIcons.circleXmark,
      color: Color(0xFFF44336),
    )
    ..text = '失败'
    ..color = const Color(0xFFF44336);

  factory UiToastMessage.loading() => UiToastMessage()
    ..icon = const FaIcon(
      FontAwesomeIcons.spinner,
      color: Color(0xFF2196F3),
    )
    ..text = '加载中'
    ..color = const Color(0xFF2196F3)
    ..autoClose = false;

  Widget icon = const FaIcon(FontAwesomeIcons.circle);
  String text = '无';
  Color color = const Color(0xFF000000);
  bool autoClose = true;

  //
  // ignore:avoid_positional_boolean_parameters
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
            padding: EdgeInsets.all(10.r),
            constraints: BoxConstraints(
              minWidth: 140.r,
            ),
            decoration: BoxDecoration(
              color: Color.lerp(
                widget.message.color,
                const Color(0xFFFFFFFF),
                .95,
              ),
              border: Border.all(
                color: widget.message.color,
                width: 1.5.r,
              ),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.message.icon,
                    SizedBox(width: 5.r),
                    Text(
                      widget.message.text,
                      style: TextStyle(
                        color: widget.message.color,
                        fontSize: 15.r,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                if (widget.message.choiceCallback != null)
                  SizedBox(height: 10.r),
                if (widget.message.choiceCallback != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UiTextButton(
                        background: false,
                        onTap: () {
                          widget.message.choiceCallback!(false);
                          UiToast.dismiss();
                        },
                        text: '取消',
                      ),
                      SizedBox(width: 10.r,),
                      UiTextButton(
                        background: false,
                        onTap: () {
                          widget.message.choiceCallback!(true);
                          UiToast.dismiss();
                        },
                        text: '确定',
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
