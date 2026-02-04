import 'package:flutter/widgets.dart';

class FnNav {
  FnNav._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
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
      FnNavRouteBuilder<T>(
        RouteSettings(arguments: args),
        (context) => page(),
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
      FnNavRouteBuilder<T>(
        RouteSettings(arguments: args),
        (context) => page(),
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
      FnNavRouteBuilder<T>(
        RouteSettings(arguments: args),
            (context) => page(),
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

class FnNavRouteBuilder<T> extends PageRouteBuilder<T> {
  FnNavRouteBuilder(RouteSettings settings, this.builder)
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
