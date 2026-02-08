import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_disable/ui_disable.dart';
import 'package:ui_theme/ui_theme.dart';

class UiButton extends StatelessWidget {
  const UiButton({
    required this.child,
    super.key,
    this.width,
    this.height,
    this.color,
    this.background = true,
    this.padding,
    this.onTap,
  });

  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsets? padding;

  final Color? color;
  final bool background;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? UiTheme.primaryColor;
    final child = Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 10.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: color),
        color: background ? color : const Color(0xFFFFFFFF),
      ),
      width: width,
      height: height ?? 28.r,
      alignment: Alignment.center,
      child: DefaultTextStyle.merge(
        style: TextStyle(color: background ? Color(0xFFFFFFFF) : color),
        child: IconTheme.merge(
          data: const IconThemeData(
            color: Color(0xFFFFFFFF),
          ),
          child: this.child,
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
