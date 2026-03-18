import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_disable/ui_disable.dart';
import 'package:ui_theme/ui_theme.dart';

class UiIconButton extends StatelessWidget {
  const UiIconButton({
    required this.icon,
    this.size,
    super.key,
    this.width,
    this.height,
    this.color,
    this.onTap,
    this.background = true,
  });

  final double? size;
  final double? width;
  final double? height;
  final IconData icon;
  final bool background;
  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? UiTheme.primaryColor;
    double? iconSize;
    if (!background) {
      iconSize = 16.r;
    }
    if (size != null) {
      iconSize = size;
    }
    final child = Container(
      decoration: background
          ? BoxDecoration(
              shape: BoxShape.circle,
              color: color.withAlpha(20),
            )
          : null,
      alignment: Alignment.center,
      width: width ?? 28.r,
      height: height ?? 28.r,
      child: Icon(
        icon,
        size: iconSize,
        color: color,
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
