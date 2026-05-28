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

  static Future<bool?>? show(UiToastMessage message, {bool root = false}) {
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    return Navigator.of(navContext, rootNavigator: root).push<bool?>(
      _route(ToastWidget(message: message)),
    );
  }

  static void Function()? showLoading(
    UiToastMessage message, {
    bool root = false,
  }) {
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    final route = _route(const ToastLoadingWidget());

    /*void pop() {
      if (route.isActive) {
        //避免重复关闭
        Navigator.of(navContext).removeRoute<bool?>(route, true);
      }
    }*/

    /*route = PageRouteBuilder<bool?>(
      opaque: false,
      fullscreenDialog: true,
      barrierColor: const Color(0x00000000),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondaryAnimation) {
        return PopScope(
          canPop: false, //false 时
          onPopInvokedWithResult: (didPop, result) {
            //didPop 是否实际发生了返回
          },
          child: const ToastLoadingWidget(),
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );*/



    unawaited(Navigator.of(navContext, rootNavigator: root).push<bool?>(route));

    return () {
      if (route.isActive) {
        //避免重复关闭
        Navigator.of(navContext).removeRoute<bool?>(route, true);
      }
    };
  }

  static PageRouteBuilder<bool?> _route(Widget child) =>
      PageRouteBuilder<bool?>(
        opaque: false,
        fullscreenDialog: true,
        barrierColor: const Color(0x00000000),
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondaryAnimation) => PopScope(
          canPop: false,
          /*onPopInvokedWithResult: (didPop, result) {
        //didPop 是否实际发生了返回
      },*/
          child: child,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            child,
      );
}
