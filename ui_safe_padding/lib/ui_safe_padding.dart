import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class UiSafePadding extends StatelessWidget {
  const UiSafePadding({
    this.bottom = true,
    this.left = true,
    this.right = true,
    this.top = true,
    this.child,
    super.key,
  });

  final Widget? child;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    final padding = paddingData(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        left ? padding.left : 0,
        top ? padding.top : 0,
        right ? padding.right : 0,
        bottom ? padding.bottom : 0,
      ),
      child: child,
    );
  }
}

EdgeInsets? _paddingData;

EdgeInsets paddingData(BuildContext context) {
  if (_paddingData != null) {
    return _paddingData!;
  }
  final mediaQueryData = MediaQuery.of(context);
  final padding = mediaQueryData.padding;
  final viewPadding = mediaQueryData.viewPadding;

  final bottom = viewPadding.bottom * .3;

  final flutterView = PlatformDispatcher.instance.views.first;
  final pw = flutterView.physicalSize.width;
  final ph = flutterView.physicalSize.height;
  final width = min(pw, ph) / flutterView.devicePixelRatio;
  final left = width / 375 * 10;

  _paddingData = EdgeInsets.fromLTRB(left, padding.top * .75, left, bottom);
  return _paddingData!;
}
