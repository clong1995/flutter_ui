import 'package:flutter/material.dart';
import 'package:ui_alert/src/widget/cancel_button.dart';
import 'package:ui_alert/src/widget/config.dart';
import 'package:ui_alert/src/widget/title.dart';

Future<bool?> fnAlertDelete({
  required BuildContext context,
  String? content,
  bool root = true,
}) async => showDialog<bool>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const TitleWidget(text: '删除提示:'),
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
              Icons.delete_forever_outlined,
              size: 36,
              color: Colors.red,
            ),
          ),
          Text(content ?? '确定要删除吗?'),
        ],
      ),
    ),
    actions: <Widget>[
      const CancelButton(),
      FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.red.withAlpha(20),
          shadowColor: Colors.red.withAlpha(20),
        ),
        child: const Text('删除', style: TextStyle(color: Colors.red)),
        onPressed: () => Navigator.pop(context, true),
      ),
    ],
  ),
);
