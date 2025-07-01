import 'package:flutter/material.dart';

import 'widget/cancel_button.dart';
import 'widget/confirm_button.dart';
import 'widget/title.dart';
import 'widget/config.dart';

Future<bool?> alertConfirm({
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
    title: const TitleWidget(text: "确认提示:"),
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
          Text(content?? "确定要执行吗?"),
        ],
      ),
    ),
    actions: const <Widget>[CancelButton(), ConfirmButton()],
  ),
);
