import 'package:flutter/material.dart';

class FnNav {
  FnNav._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  static void init({
    required GlobalKey<NavigatorState> navigatorKey,
  }) {
    _navigatorKey = navigatorKey;
  }

  static Future<T?> push<T extends Object?>(
    Widget Function() page, {
    bool root = false,
    Object? args,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return Navigator.of(context, rootNavigator: root).push<T>(
      MaterialPageRoute<T>(
        builder: (BuildContext context) => page(),
        settings: RouteSettings(arguments: args),
      ),
    );
  }

  static Future<T?> pushAndRemove<T extends Object?>(
    Widget Function() page, {
    bool root = false,
    Object? args,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }

    return Navigator.of(context, rootNavigator: root).pushAndRemoveUntil<T>(
      MaterialPageRoute<T>(
        builder: (BuildContext context) => page(),
        settings: RouteSettings(arguments: args),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static Future<T?> pushAndReplace<T extends Object?, TO extends Object?>(
    Widget Function() page, {
    bool root = false,
    Object? args,
  }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return Navigator.pushReplacement<T, TO>(
      context,
      MaterialPageRoute<T>(
        builder: (BuildContext context) => page(),
        settings: RouteSettings(arguments: args),
      ),
    );
  }

  static void pop<T extends Object?>({
    bool root = false,
    T? result,
  }) {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return;
    }
    return Navigator.of(context, rootNavigator: root).pop<T>(result);
  }

  static T? routeArgs<T>() {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      return arguments as T;
    }
    return null;
  }
}
