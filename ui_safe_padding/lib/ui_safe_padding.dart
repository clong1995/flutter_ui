import 'dart:math';
import 'dart:ui';

import 'package:fn_device/fn_device.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rpx/ext.dart';

class UiSafePadding extends StatelessWidget {
  const new({
    this.addBottom = 0,
    this.addLeft = 0,
    this.addRight = 0,
    this.addTop = 0,
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.top = true,
    this.child,
    super.key,
  });

  final Widget? child;
  final bool left;
  final double addLeft;
  final bool top;
  final double addTop;
  final bool right;
  final double addRight;
  final bool bottom;
  final double addBottom;

  @override
  Widget build(BuildContext context) {
    final padding = uiSafePaddingData(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ? padding.left + addLeft : 0,
        top ? padding.top + addTop : 0,
        right ? padding.right + addRight : 0,
        bottom ? padding.bottom + addBottom : 0,
      ),
      child: child,
    );
  }
}

EdgeInsets uiSafePaddingData(BuildContext context) {
  return EdgeInsets.fromLTRB(
    10.r,
    FnDevice.statusBarHeight == 0 ? 10.r : FnDevice.statusBarHeight,
    10.r,
    FnDevice.bottomSafeHeight == 0 ? 10.r : FnDevice.bottomSafeHeight,
  );
}
