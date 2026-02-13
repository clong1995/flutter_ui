import 'package:flutter/widgets.dart';
/*import 'package:ui_alert/src/confirm.dart';
import 'package:ui_alert/src/custom.dart';
import 'package:ui_alert/src/delete.dart';
import 'package:ui_alert/src/info.dart';

export 'package:ui_alert/src/custom.dart' show UiAlertCustomContent;*/

class UiAlert {
  UiAlert._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  static Future<T?> dialog<T extends Object?>(
    Widget Function() builder, {
    bool root = false,
    Object? args,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return Navigator.of(context, rootNavigator: root).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierColor: const Color(0x80000000),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        settings: RouteSettings(arguments: args),
        pageBuilder: (context, animation, secondaryAnimation) => builder(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child,
      ),
    );
  }

  /*static Future<bool?> info({
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
  }*/
}

class _RouteBuilder<T> extends PageRouteBuilder<T> {
  _RouteBuilder(RouteSettings settings, this.builder)
    : super(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child,
      );
  final WidgetBuilder builder;
}
