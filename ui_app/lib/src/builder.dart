import 'package:flutter/widgets.dart';
import 'package:ui_theme/ui_theme.dart';

Widget builder(BuildContext context, Widget? child) {
  const color = UiTheme.gary900;
  //空白收起键盘
  final keyboard = GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus?.unfocus();
      }
    },
    child: child,
  );

  //final keyboard = child!;

  //文字
  final defaultTextStyle = DefaultTextStyle(
    style: TextStyle(
      color: color,
      fontSize: UiTheme.fontSize,
    ),
    child: keyboard,
  );

  //图标
  final iconTheme = IconTheme(
    data: IconThemeData(
      color: color,
      size: UiTheme.fontSize,
    ),
    child: defaultTextStyle,
  );

  //滚动条
  final scrollConfiguration = ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(scrollbars: false),
    child: iconTheme,
  );

  //媒体查询
  final mediaQueryData = MediaQuery.of(context);
  final safePadding = mediaQueryData.padding.copyWith(
    //top: mediaQueryData.padding.top * .75,
    left: 0,
    right: 0,
    bottom: mediaQueryData.viewPadding.bottom * .3,
  );
  final mediaQuery = MediaQuery(
    data: mediaQueryData.copyWith(
      //去掉字体缩放
      textScaler: TextScaler.noScaling,
      //自定义安全区
      padding: safePadding,
      viewPadding: safePadding,
    ),
    child: scrollConfiguration,
  );

  return mediaQuery;
}
