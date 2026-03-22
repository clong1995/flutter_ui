import 'package:flutter/widgets.dart';

class FnNav {
  FnNav._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  static Future<T?> push<T extends Object?>(Widget Function() page, {
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

  static Future<T?> pushAndRemove<T extends Object?>(Widget Function() page, {
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
          (route) => false,
    );
  }

  static Future<T?> pushAndReplace<T extends Object?, TO extends Object?>(
      Widget Function() page, {
        bool root = false,
        Object? args,
        TO? result,
      }) async {
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }
    return Navigator.of(context, rootNavigator: root).pushReplacement<T, TO>(
      FnNavRouteBuilder<T>(
        RouteSettings(arguments: args),
            (context) => page(),
      ),
      result: result,
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

  static T? routeArgs<T>(BuildContext context) {
    /*
    //这个context拿不到参数
    final context = _navigatorKey?.currentContext;
    if (context == null) {
      return null;
    }*/
    final arguments = ModalRoute
        .of(context)
        ?.settings
        .arguments;
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
