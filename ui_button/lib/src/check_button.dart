import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';
import 'package:ui_disable/ui_disable.dart';
import 'package:ui_theme/ui_theme.dart';

class UiCheckButton extends StatefulWidget {
  const UiCheckButton({
    required this.title,
    super.key,
    this.checked = false,
    this.onChanged,
  });

  final String title;
  final bool checked;
  final void Function(bool)? onChanged;

  @override
  State<UiCheckButton> createState() => _UiCheckButtonState();
}

class _UiCheckButtonState extends State<UiCheckButton> {
  @override
  Widget build(BuildContext context) {
    final color = UiTheme.primaryColor;
    final Widget child = Container(
      constraints: BoxConstraints(minHeight: 24.r),
      decoration: BoxDecoration(
        color: widget.checked ? color.withAlpha(25) : const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          color: widget.checked ? color : const Color(0xFF9E9E9E),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(width: 5.r),
          if (widget.checked)
            FaIcon(FontAwesomeIcons.squareCheck, color: color)
          else
            const FaIcon(
              FontAwesomeIcons.square,
              color: Color(0xFF9E9E9E),
            ),
          SizedBox(width: 5.r),
          Text(
            widget.title,
            style: TextStyle(color: widget.checked ? color : null),
          ),
          SizedBox(width: 5.r),
        ],
      ),
    );
    return widget.onChanged == null
        ? UiDisable(child: child)
        : GestureDetector(
      behavior: HitTestBehavior.opaque,
            onTap: () =>widget.onChanged!(!widget.checked),
            child: child,
          );
  }
}
