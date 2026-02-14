import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_theme/ui_theme.dart';
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
    final navContext = _navigatorKey?.currentContext;
    if (navContext == null) {
      return null;
    }

    final route = PageRouteBuilder<T>(
      opaque: false,
      barrierColor: const Color(0x00000000),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      settings: RouteSettings(arguments: args),
      pageBuilder: (context, animation, secondaryAnimation) => builder(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          child,
    );

    return Navigator.of(navContext, rootNavigator: root).push<T>(route);
  }

  /*static Future<bool?> info({
    required String content,
    bool root = true,
  }) async {
    return dialog<bool>(builder,root: root);
  }*/

  static Future<T?> custom<T extends Object?>({
    required Widget Function() builder,
    required String title,
    bool root = false,
    Object? args,
  }) async {
    return dialog<T>(
      () => _CustomWidget(
        title: title,
      ),
      root: root,
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

class _CustomWidget extends StatelessWidget {
  const _CustomWidget({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IntrinsicWidth(
        child: Container(
          clipBehavior : Clip.hardEdge,
          constraints: BoxConstraints(
            minWidth: 300.r,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF),
            border: Border.all(
              color: const Color(0xFF9E9E9E),
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize : MainAxisSize.min,
            children: [
              Container(
                color: UiTheme.primaryColor,
                height: 30.r,
                alignment: Alignment.center,
                child: Text(title,style: TextStyle(
                  color: Color(0xFFFFFFFF),
                ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
