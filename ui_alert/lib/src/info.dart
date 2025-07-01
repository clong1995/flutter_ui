import 'package:flutter/material.dart';

import 'widget/config.dart';
import 'widget/confirm_button.dart';
import 'widget/title.dart';

Future<bool?> alertInfo({
  required BuildContext context,
  required String content,
  bool root = true,
}) async => showDialog<bool>(
  context: context,
  barrierColor: Config.barrierColor,
  barrierDismissible: false,
  useRootNavigator: root,
  builder: (BuildContext context) => AlertDialog(
    clipBehavior: Clip.antiAlias,
    title: const TitleWidget(text: "特别提示:"),
    titleTextStyle: Config.titleStyle,
    titlePadding: Config.titlePadding,
    contentPadding: Config.contentPadding,
    content: SizedBox(
      // width: Config.width,
      child: DecoratedBox(
        decoration: Config.decoration,
        child: Center(child: Text(content)),
      ),
    ),
    actions: const <Widget>[ConfirmButton()],
  ),
);
