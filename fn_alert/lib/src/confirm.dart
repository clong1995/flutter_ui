import 'package:flutter/material.dart';
import 'package:ui_alert/src/widget/cancel_button.dart';
import 'package:ui_alert/src/widget/config.dart';
import 'package:ui_alert/src/widget/confirm_button.dart';
import 'package:ui_alert/src/widget/title.dart';

Future<bool?> fnAlertConfirm({
  required BuildContext context,
  String? content,
  bool root = true,
}) => showDialog<bool>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const TitleWidget(text: '确认提示:'),
    titleTextStyle: Config.titleStyle,
    titlePadding: Config.titlePadding,
    contentPadding: Config.contentPadding,
    content: Container(
      width: Config.width,
      padding: Config.bottomPadding,
      decoration: Config.decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: Config.bottomPadding,
            child: Icon(
              Icons.notifications_active_outlined,
              size: 36,
              color: Colors.orange,
            ),
          ),
          Text(content?? '确定要执行吗?'),
        ],
      ),
    ),
    actions: const <Widget>[CancelButton(), ConfirmButton()],
  ),
);
