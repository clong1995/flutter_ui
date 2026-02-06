import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';
import 'package:ui_disable/ui_disable.dart';
import 'package:ui_theme/ui_theme.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({
    required this.title,
    super.key,
    this.onTap,
  });

  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final color = UiTheme.primaryColor;
    final Widget child = Container(
      constraints: BoxConstraints(minHeight: 24.r),
      decoration: BoxDecoration(
        color: color.withAlpha(25),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(color: color),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5.r),
          Text(title, style: TextStyle(color: color)),
          SizedBox(width: 5.r),
          FaIcon(FontAwesomeIcons.xmark,color: color,),
          SizedBox(width: 5.r),
        ],
      ),
    );
    return onTap == null ? UiDisable(child: child) : GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: child,
    );
  }
}
