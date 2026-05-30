import 'package:flutter/widgets.dart';

class NoScrollBehavior extends ScrollBehavior {
  //去掉滚动到边界时出现的光晕效果
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;

  //来禁用 iOS 回弹效果
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      const ClampingScrollPhysics();
}
