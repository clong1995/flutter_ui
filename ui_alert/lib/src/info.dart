import 'package:flutter/material.dart';

import 'package:ui_alert/src/widget/config.dart';
import 'package:ui_alert/src/widget/confirm_button.dart';
import 'package:ui_alert/src/widget/title.dart';

Future<bool?> infoDialog({
  required BuildContext context,
  required String content,
  bool root = true,
}) => showDialog<bool>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const TitleWidget(text: '特别提示:'),
    titleTextStyle: Config.titleStyle,
    titlePadding: Config.titlePadding,
    contentPadding: Config.contentPadding,
    content: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: Config.bottomPadding,
          child: Icon(
            Icons.info_outline,
            size: 36,
            color: Colors.orange,
          ),
        ),
        Text(content),
      ],
    ),
    actions: const <Widget>[ConfirmButton()],
  ),
);
