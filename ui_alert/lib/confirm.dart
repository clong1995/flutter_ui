import 'package:flutter/material.dart';

import 'src/alert_cancel_button.dart';
import 'src/alert_confirm_button.dart';
import 'src/alert_title.dart';
import 'src/config.dart';

Future<bool?> confirm({
  required BuildContext context,
  String? content,
  bool useRootNavigator = true,
}) async => showDialog<bool>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: useRootNavigator,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const AlertTitle(text: "确认提示:"),
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
          Padding(
            padding: Config.bottomPadding,
            child: Icon(Icons.notifications_active_outlined, size: 36),
          ),
          Text(content ?? "确定要执行吗?"),
        ],
      ),
    ),
    actions: const <Widget>[AlertCancelButton(), AlertConfirmButton()],
  ),
);
