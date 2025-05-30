import 'package:flutter/material.dart';

import 'src/confirm.dart' as alert;
import 'src/custom.dart' as alert;
import 'src/delete.dart' as alert;
import 'src/info.dart' as alert;

class Alert {
  static Future<bool?> confirm({
    required BuildContext context,
    String? content,
    bool root = true,
  }) => alert.confirm(context: context, content: content, root: root);

  static Future<T?> custom<T>({
    required BuildContext context,
    required Widget child,
    bool root = true,
  }) => alert.custom(context: context, child: child, root: root);

  static Future<bool?> delete({
    required BuildContext context,
    String? content,
    bool root = true,
  }) => alert.delete(context: context, content: content, root: root);

  static Future<bool?> info({
    required BuildContext context,
    required String content,
    bool root = true,
  }) => alert.info(context: context, content: content, root: root);

  static Widget customContent({
    required String title,
    required Widget child,
    List<Widget>? action,
  }) => alert.CustomContent(title: title, action: action, child: child);
}
