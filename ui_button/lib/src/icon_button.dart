import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';
import 'package:ui_disable/ui_disable.dart';

class UiIconButton extends StatelessWidget {
  const UiIconButton({
    required this.icon,
    this.size,
    super.key,
    this.width,
    this.decoration,
    this.height,
    this.color,
    this.onTap,
  });

  final double? size;
  final double? width;
  final double? height;
  final IconData icon;
  final BoxDecoration? decoration;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: decoration,
      width: width ?? 30.r,
      height: height ?? 30.r,
      child: Center(
        child: FaIcon(
          icon,
          size: size,
          color: color,
        ),
      ),
    );
    return onTap == null
        ? UiDisable(child: child)
        : GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: child,
          );
  }
}
