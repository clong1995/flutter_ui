import 'package:flutter/widgets.dart';
import 'package:ui_alert/src/confirm.dart';
import 'package:ui_alert/src/custom.dart';
import 'package:ui_alert/src/delete.dart';
import 'package:ui_alert/src/info.dart';

export 'package:ui_alert/src/custom.dart' show UiAlertCustomContent;

class UiAlert {
  UiAlert._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }


  static Future<bool?> info({
    required String content,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return infoDialog(
      context: context,
      content: content,
      root: root,
    );
  }

  static Future<bool?> delete({
    String? content,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return deleteDialog(context: context, content: content, root: root);
  }

  static Future<T?> custom<T>({
    required Widget child,
    bool root = true,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return customDialog(context: context, child: child, root: root);
  }

  static Future<bool?> confirm({
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
