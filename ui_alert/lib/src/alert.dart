import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:ui_theme/ui_theme.dart';

class UiAlert {
  new _();

  static GlobalKey<NavigatorState>? _navigatorKey;

  //
  // ignore:avoid_setters_without_getters
  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  static Future<T?> dialog<T extends Object?>(
    Widget Function(BuildContext) builder, {
    bool root = false,
    Object? args,
  }) async {
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    return await Navigator.of(navContext, rootNavigator: root).push<T>(
      FnNavRoute<T>(
        opaque: false,
        barrierColor: UiTheme.black.withAlpha(50),
        settings: RouteSettings(arguments: args),
        builder: (context) => PopScope(
          canPop: false,
          child: builder(context),
        ),
      ),
    );
  }
}
