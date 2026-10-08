import 'package:flutter/widgets.dart';

class FnNav {
  new _();

  static GlobalKey<NavigatorState>? _navigatorKey;

  static set navigatorKey(GlobalKey<NavigatorState> value) {
    _navigatorKey = value;
  }

  static Future<T?> push<T extends Object?>(
    Widget Function() page, {
    bool root = false,
    Object? args,
  }) async {
    final currentState = _navigatorKey?.currentContext;
    if (currentState == null) {
      return null;
    }

    return await Navigator.of(currentState, rootNavigator: root).push<T>(
      FnNavRoute<T>(
        settings: RouteSettings(arguments: args),
        builder: (context) => page(),
      ),
    );
  }

  static Future<T?> pushAndRemove<T extends Object?>(
    Widget Function() page, {
    bool root = false,
    Object? args,
  }) async {
    final currentState = _navigatorKey?.currentContext;
    if (currentState == null) {
      return null;
    }

    final navigator = Navigator.of(currentState, rootNavigator: root);

    return await navigator.pushAndRemoveUntil<T>(
      FnNavRoute<T>(
        settings: RouteSettings(arguments: args),
        builder: (context) => page(),
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
    final currentState = _navigatorKey?.currentContext;
    if (currentState == null) {
      return null;
    }

    return await Navigator.of(
      currentState,
      rootNavigator: root,
    ).pushReplacement<T, TO>(
      FnNavRoute<T>(
        settings: RouteSettings(arguments: args),
        builder: (context) => page(),
      ),
      result: result,
    );
  }

  static void pop<T extends Object?>({bool root = false, T? result}) {
    final currentState = _navigatorKey?.currentContext;

    if (currentState == null) {
      return;
    }

    Navigator.of(currentState, rootNavigator: root).pop<T>(result);
  }

  static T? routeArgs<T>(BuildContext context) {
    final arguments = FnNavScope.argumentsOf(context);

    if (arguments != null) {
      return arguments as T;
    }

    return null;
  }

  static bool canPop({bool root = false}) {
    final currentState = _navigatorKey?.currentContext;
    if (currentState == null) {
      return false;
    }

    return Navigator.of(currentState, rootNavigator: root).canPop();
  }
}

///
/// 不带任何动画的 Route。
///
/// 和 PageRouteBuilder 不同，这里直接继承 OverlayRoute，
/// 因此不存在 transitionDuration / reverseTransitionDuration。
///
class FnNavRoute<T> extends OverlayRoute<T> {
  new({required this.builder, super.settings});

  final WidgetBuilder builder;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return <OverlayEntry>[
      OverlayEntry(
        opaque: true,
        builder: (context) {
          return FnNavScope(
            arguments: settings.arguments,
            child: builder(context),
          );
        },
      ),
    ];
  }
}

///
/// 给页面提供 route arguments。
///
/// 因为 FnNavRoute 不再是 ModalRoute，
/// 所以不能继续使用 ModalRoute.of(context)。
///
class FnNavScope extends InheritedWidget {
  const new({required this.arguments, required super.child, super.key});

  final Object? arguments;

  static Object? argumentsOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FnNavScope>()?.arguments;
  }

  @override
  bool updateShouldNotify(FnNavScope oldWidget) {
    return arguments != oldWidget.arguments;
  }
}

///
/// 这个类继续保留。
///
/// WidgetsApp 的 pageRouteBuilder 需要它，
/// 所以不要删除。
///
/*class FnNavRouteBuilder<T> extends PageRouteBuilder<T> {
  new(
      RouteSettings settings,
      this.builder,
      ) : super(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) =>
        builder(context),
    transitionDuration: .zero,
    reverseTransitionDuration: .zero,
    transitionsBuilder: (
        context,
        animation,
        secondaryAnimation,
        child,
        ) => child,
  );

  final WidgetBuilder builder;
}*/
