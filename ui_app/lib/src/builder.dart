import 'package:flutter/material.dart';
import 'package:ui_app/src/no_scroll_behavior.dart';
import 'package:ui_theme/ui_theme.dart';

Widget appBuilder(
  BuildContext context,
  Widget? child,
  Widget Function(BuildContext, Widget?)? builder,
) {
  const color = UiTheme.grey900;

  late Widget builderWidget;
  if (builder == null) {
    builderWidget = child!;
  } else {
    builderWidget = builder(context, child);
  }

  //空白收起键盘
  //涉及到输入组件，我已经内部处理了
  /*final keyboard = GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    },
    child: builderWidget,
  );*/

  //final keyboard = child!;

  //文字
  final defaultTextStyle = DefaultTextStyle(
    style: TextStyle(
      color: color,
      fontSize: UiTheme.fontSize,
      fontFamily: UiTheme.fontFamily,
    ),
    child: builderWidget,
  );



  //光标
  final textSelectionTheme = TextSelectionTheme(
    data: TextSelectionThemeData(
      cursorColor: UiTheme.primaryColor,
      selectionColor: UiTheme.primaryColor.withAlpha(100),
      selectionHandleColor: UiTheme.primaryColor,
    ),
    child: defaultTextStyle,
  );

  //图标
  final iconTheme = IconTheme(
    data: IconThemeData(
      color: color,
      size: UiTheme.fontSize,
    ),
    child: textSelectionTheme,
  );

  //滚动条
  final scrollConfiguration = ScrollConfiguration(
    behavior: NoScrollBehavior().copyWith(scrollbars: false),
    child: iconTheme,
  );

  final mediaQueryData = MediaQuery.of(context);
  final mediaQuery = MediaQuery(
    data: mediaQueryData.copyWith(
      //去掉字体缩放
      textScaler: TextScaler.noScaling,
      //自定义安全区
      padding: EdgeInsets.zero,
    ),
    child: scrollConfiguration,
  );

  return mediaQuery;
}
