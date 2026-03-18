import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_toast/src/message.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({required this.message, super.key});

  final UiToastMessage message;

  @override
  State<ToastWidget> createState() => ToastWidgetState();
}

class ToastWidgetState extends State<ToastWidget> {
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
              if (widget.message.callback != null) ...[
                SizedBox(height: 10.r),
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
              ],
              if (showCloseButton) ...[
                SizedBox(height: 10.r),
                UiTextButton(
                  text: '关闭',
                  color: widget.message.color,
                  onTap: Navigator.of(context).pop,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
