import 'package:flutter/material.dart';

import 'widget/alert_cancel_button.dart';
import 'widget/alert_confirm_button.dart';
import 'widget/alert_title.dart';
import 'widget/alert_config.dart';

Future<bool?> confirm({
  required BuildContext context,
  String? content,
  bool root = true,
}) => showDialog<bool>(
  context: context,
  barrierColor: AlertConfig.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const AlertTitle(text: "确认提示:"),
    titleTextStyle: AlertConfig.titleStyle,
    titlePadding: AlertConfig.titlePadding,
    contentPadding: AlertConfig.contentPadding,
    content: Container(
      width: AlertConfig.width,
      padding: AlertConfig.bottomPadding,
      decoration: AlertConfig.decoration,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: AlertConfig.bottomPadding,
            child: Icon(Icons.notifications_active_outlined, size: 36),
          ),
          Text(content ?? "确定要执行吗?"),
        ],
      ),
    ),
    actions: const <Widget>[AlertCancelButton(), AlertConfirmButton()],
  ),
);
