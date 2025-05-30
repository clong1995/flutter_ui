import 'package:flutter/material.dart';

import 'widget/alert_cancel_button.dart';
import 'widget/alert_title.dart';
import 'widget/alert_config.dart';

Future<bool?> delete({
  required BuildContext context,
  String? content,
  bool root = true,
}) async => showDialog<bool>(
  context: context,
  barrierColor: AlertConfig.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const AlertTitle(text: "删除提示:"),
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
            child: Icon(
              Icons.delete_forever_outlined,
              size: 36,
              color: Colors.red,
            ),
          ),
          Text(content ?? "确定要删除吗?"),
        ],
      ),
    ),
    actions: <Widget>[
      const AlertCancelButton(),
      FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.withAlpha(20),
          shadowColor: Colors.red.withAlpha(20),
        ),
        child: const Text("删除", style: TextStyle(color: Colors.red)),
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  ),
);
