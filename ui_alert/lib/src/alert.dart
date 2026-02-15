import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    return Navigator.of(navContext, rootNavigator: root).push<T>(
      PageRouteBuilder<T>(
        opaque: false,
        barrierColor: const Color(0x00000000),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        settings: RouteSettings(arguments: args),
        pageBuilder: (context, animation, secondaryAnimation) => builder(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        child,
      ),
    );
  }
}
