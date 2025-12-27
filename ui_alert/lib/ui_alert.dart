import 'package:flutter/material.dart';
import 'package:ui_alert/src/confirm.dart';
import 'package:ui_alert/src/custom.dart';
import 'package:ui_alert/src/delete.dart';
import 'package:ui_alert/src/info.dart';

export 'package:ui_alert/src/custom.dart' show UiAlertCustomContent;

class UiAlert {
  UiAlert._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  static void init({
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    _navigatorKey = navigatorKey;
  }

  static Future<bool?> info({
    //required BuildContext context,
    required String content,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return infoDialog(
      context: context!,
      content: content,
      root: root,
    );
  }

  Future<bool?> delete({
    //required BuildContext context,
    String? content,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return deleteDialog(context: context, content: content, root: root);
  }

  Future<T?> custom<T>({
    //required BuildContext context,
    required Widget child,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return customDialog(context: context, child: child, root: root);
  }

  Future<bool?> confirm({
    //required BuildContext context,
    String? content,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return confirmDialog(context: context, content: content, root: root);
  }
}
