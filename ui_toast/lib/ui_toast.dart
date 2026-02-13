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

  //static OverlayEntry? _entry;
  //static Timer? _timer;

  /*static void show(UiToastMessage message) {
    final overlay = _navigatorKey?.currentState?.overlay;
    if (overlay == null) {
      return;
    }

    dismiss();

    _entry = OverlayEntry(
      builder: (_) => _ToastWidget(message: message),
    );

    overlay.insert(_entry!);

    if (message.choiceCallback != null) {
      return;
    }

    _timer = Timer(const Duration(seconds: 1), dismiss);
  }*/

  /*static void dismiss() {
    _timer?.cancel();
    _timer = null;

    _entry?.remove();
    _entry = null;
  }*/

  static void Function()? show(UiToastMessage message) {
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    late PageRouteBuilder<void> route;

    void pop() {
      if (route.isActive) {
        Navigator.of(navContext).removeRoute(route);
      }
    }

    route = PageRouteBuilder<void>(
      opaque: false,
      barrierColor: const Color(0x00000000),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) {
        Timer? timer;
        if (message.autoPopSeconds > 0) {
          timer = Timer(
            Duration(seconds: message.autoPopSeconds),
            pop,
          );
        }
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            timer?.cancel();
            if (message.autoPopSeconds > 0) pop();
          },
          child: _ToastWidget(message: message),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );

    unawaited(Navigator.of(navContext).push<void>(route));

    return pop;
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
    ..autoPopSeconds = -1;

  Widget icon = const FaIcon(FontAwesomeIcons.circle);
  String text = '无';
  Color color = const Color(0xFF000000);
  int autoPopSeconds = 1; //0秒:永不关闭，-1:永不关闭但是等待大于等于5秒:将出关闭按钮

  //
  // ignore:avoid_positional_boolean_parameters
  void Function(bool value)? callback;
}

class _ToastWidget extends StatefulWidget {
  const _ToastWidget({required this.message});

  final UiToastMessage message;

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget> {
  bool showCloseButton = false;

  @override
  void initState() {
    super.initState();
    if (widget.message.autoPopSeconds <= -1) {
      Future.delayed(const Duration(seconds: 5), () {
        setState(() {
          showCloseButton = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.message.autoPopSeconds > 0 ? null : const Color(0x80000000),
      alignment: Alignment.center,
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.all(10.r),
          constraints: BoxConstraints(
            minWidth: 140.r,
            maxWidth: 370.r,
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
              if (widget.message.callback != null) SizedBox(height: 10.r),
              if (widget.message.callback != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiButton(
                      background: false,
                      onTap: () {
                        widget.message.callback!(false);
                        Navigator.of(context).pop();
                      },
                      child: const Text('取消'),
                    ),
                    SizedBox(
                      width: 10.r,
                    ),
                    UiButton(
                      onTap: () {
                        widget.message.callback!(true);
                        Navigator.of(context).pop();
                      },
                      child: const Text('确定'),
                    ),
                  ],
                ),
              if (showCloseButton) SizedBox(height: 10.r),
              if (showCloseButton)
                UiTextButton(
                  text: '关闭',
                  color: widget.message.color,
                  onTap: Navigator.of(context).pop,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
