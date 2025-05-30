import 'package:flutter/material.dart';

import 'widget/alert_confirm_button.dart';
import 'widget/alert_title.dart';
import 'widget/alert_config.dart';

Future<bool?> info({
  required BuildContext context,
  required String content,
  bool root = true,
}) async => showDialog<bool>(
  context: context,
  barrierColor: AlertConfig.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const AlertTitle(text: "特别提示:"),
    titleTextStyle: AlertConfig.titleStyle,
    titlePadding: AlertConfig.titlePadding,
    contentPadding: AlertConfig.contentPadding,
    content: Container(
      width: AlertConfig.width,
      padding: AlertConfig.bottomPadding,
      decoration: AlertConfig.decoration,
      alignment: Alignment.center,
      child: Text(content),
    ),
    actions: const <Widget>[AlertConfirmButton()],
  ),
);
