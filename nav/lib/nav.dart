import 'package:flutter/material.dart';

class Nav {
  static Future<T?> push<T extends Object?>(
      BuildContext context,
      Widget Function() page, {
        bool root = false,
        Object? args,
      }) => Navigator.of(context, rootNavigator: root).push<T>(
    MaterialPageRoute<T>(
      builder: (BuildContext context) => page(),
      settings: RouteSettings(arguments: args),
    ),
  );

  static Future<T?> pushAndRemove<T extends Object?>(
      BuildContext context,
      Widget Function() page, {
        bool root = false,
        Object? args,
      }) => Navigator.of(context, rootNavigator: root).pushAndRemoveUntil<T>(
    MaterialPageRoute<T>(
      builder: (BuildContext context) => page(),
      settings: RouteSettings(arguments: args),
    ),
        (Route<dynamic> route) => false,
  );

  static void pop<T extends Object?>(
      BuildContext context, {
        bool root = false,
        T? result,
      }) => Navigator.of(context, rootNavigator: root).pop<T>(result);

  static T? routeArgs<T>(BuildContext context) {
    Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments != null) {
      return arguments as T;
    }
    return null;
  }
}
