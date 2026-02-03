import 'package:flutter/widgets.dart';

class FnNav {
  FnNav._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
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
      _AppRoute(
        page: page(),
        settings: RouteSettings(arguments: args),
      ),
      /*PageRouteBuilder<T>(
        pageBuilder:
            (
              context,
              animation,
              secondaryAnimation,
            ) => page(),
        settings: RouteSettings(arguments: args),
      ),*/
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
      PageRouteBuilder<T>(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page(),
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
      PageRouteBuilder<T>(
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) => page(),
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

class _AppRoute<T> extends PageRouteBuilder<T> {
  _AppRoute({required this.page, super.settings})
    : super(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child,
      );
  final Widget page;
}
