import 'dart:async';

import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';
import 'package:ui_toast/src/message.dart';

class ToastWidget extends StatefulWidget {
  const ToastWidget({required this.message, super.key});

  final UiToastMessage message;

  @override
  State<ToastWidget> createState() => ToastWidgetState();
}

class ToastWidgetState extends State<ToastWidget> {


  @override
  void initState() {
    super.initState();
    if(widget.message.select){
      return;
    }
    /*WidgetsBinding.instance.addPostFrameCallback((duration) {

    });*/
    Timer(
      Duration(seconds: widget.message.autoPopSeconds),
          ()=>Navigator.of(context).pop<bool?>(true),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.all(10.r),
          constraints: BoxConstraints(
            minWidth: 140.r,
            maxWidth: 350.r,
          ),
          decoration: BoxDecoration(
            color: Color.lerp(
              widget.message.color,
              const Color(0xFFFFFFFF),
              .95,
            ),
            border: Border.all(
              color: widget.message.color,
              width: 1.r,
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
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              if (widget.message.select) ...[
                SizedBox(height: 10.r),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    UiButton(
                      background: false,
                      onTap: () => Navigator.of(context).pop<bool?>(false),
                      child: const Text('取消'),
                    ),
                    SizedBox(
                      width: 10.r,
                    ),
                    UiButton(
                      onTap: () => Navigator.of(context).pop<bool?>(true),
                      child: const Text('确定'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}



class ToastLoadingWidget extends StatefulWidget {
  const ToastLoadingWidget({super.key});

  @override
  State<ToastLoadingWidget> createState() => _ToastLoadingWidgetState();
}

class _ToastLoadingWidgetState extends State<ToastLoadingWidget> {
  bool showCloseButton = false;

  @override
  void initState() {
    super.initState();
    /*WidgetsBinding.instance.addPostFrameCallback((duration) {

    });*/
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          showCloseButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.all(10.r),
          constraints: BoxConstraints(
            minWidth: 140.r,
            maxWidth: 350.r,
          ),
          decoration: BoxDecoration(
            color: Color.lerp(
              UiTheme.primaryColor,
              const Color(0xFFFFFFFF),
              .95,
            ),
            border: Border.all(
              color: UiTheme.primaryColor,
              width: 1.r,
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
                  Icon(
                    Icons.pending_outlined,
                    color: UiTheme.primaryColor,
                  ),
                  SizedBox(width: 5.r),
                  Text(
                    '加载中',
                    style: TextStyle(
                      color:  UiTheme.primaryColor,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
              if (showCloseButton) ...[
                SizedBox(height: 10.r),
                UiTextButton(
                  text: '关闭',
                  onTap: () => Navigator.of(context).pop<bool?>(false),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
