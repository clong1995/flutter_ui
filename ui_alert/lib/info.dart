import 'package:flutter/material.dart';

import 'src/alert_confirm_button.dart';
import 'src/alert_title.dart';
import 'src/config.dart';

Future<bool?> info({
  required BuildContext context,
  required String content,
  bool useRootNavigator = true,
}) async => showDialog<bool>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: useRootNavigator,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const AlertTitle(text: "特别提示:"),
    titleTextStyle: Config.titleStyle,
    titlePadding: Config.titlePadding,
    contentPadding: Config.contentPadding,
    content: Container(
      width: Config.width,
      padding: Config.bottomPadding,
      decoration: Config.decoration,
      alignment: Alignment.center,
      child: Text(content),
    ),
    actions: const <Widget>[AlertConfirmButton()],
  ),
);
