import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';

Widget builder(BuildContext context, Widget? child) {

  final keyboard = Listener(
    onPointerUp: (event) {
      if (MediaQuery.of(context).viewInsets.bottom <= 0) {
        return;
      }
      final box = context.findRenderObject() as RenderBox?;
      if (box != null) {
        final localPosition = box.globalToLocal(event.position);
        final result = BoxHitTestResult();
        box.hitTest(result, position: localPosition);
        for (final hit in result.path) {
          if (hit.target is RenderEditable) {
            return;
          }
        }
      }
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: child ?? const Placeholder(),
  );

  //文字
  final defaultTextStyle = DefaultTextStyle(
    style: TextStyle(
      // color: Color(0xFF333333), // 默认文字颜色
      fontSize: 14.r, // 默认字体大小
    ),
    child: keyboard,
  );

  //滚动条
  final scrollConfiguration = ScrollConfiguration(
    behavior: const ScrollBehavior().copyWith(scrollbars: false),
    child: defaultTextStyle,
  );

  //媒体查询
  final mediaQueryData = MediaQuery.of(context);
  final safePadding = EdgeInsets.zero.copyWith(
    top: mediaQueryData.padding.top * .75,
    bottom: mediaQueryData.viewPadding.bottom * .3,
  );
  final mediaQuery= MediaQuery(
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
