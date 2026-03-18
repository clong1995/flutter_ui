import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:ui_toast/src/message.dart';
import 'package:ui_toast/src/widget.dart';

class UiToast {
  UiToast._();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  static void Function()? show(UiToastMessage message, {bool root = false}) {
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    late PageRouteBuilder<void> route;

    void pop() {
      if (route.isActive) {
        Navigator.of(navContext).removeRoute(route);
      }
    }

    route = PageRouteBuilder<void>(
      opaque: false,
      barrierColor: const Color(0x00000000),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) {
        Timer? timer;
        if (message.autoPopSeconds > 0) {
          timer = Timer(
            Duration(seconds: message.autoPopSeconds),
            pop,
          );
        }
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            timer?.cancel();
            if (message.autoPopSeconds > 0) pop();
          },
          child: ToastWidget(message: message),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );

    unawaited(Navigator.of(navContext, rootNavigator: root).push<void>(route));

    return pop;
  }
}
