import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_disable/ui_disable.dart';
import 'package:ui_theme/ui_theme.dart';

class UiTextButton extends StatelessWidget {
  const UiTextButton({
    required this.text,
    this.fontSize,
    super.key,
    this.height,
    this.color,
    this.background = true,
    this.padding,
    this.onTap,
  });

  final double? fontSize;
  final double? height;
  final String text;
  final bool background;
  final EdgeInsets? padding;

  final Color? color;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color = this.color ?? UiTheme.primaryColor;

    //height
    double? height;
    if(background){
      height = 28.r;
    }
    if(this.height!= null){
      height = this.height;
    }

    //padding
    EdgeInsets? padding;
    if(background){
      padding = EdgeInsets.symmetric(horizontal: 10.r);
    }
    if(this.padding!= null){
      padding = this.padding;
    }

    final child = Container(
      padding: padding,
      decoration: background
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: color.withAlpha(20),
            )
          : null,
      height: height,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: fontSize),
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
