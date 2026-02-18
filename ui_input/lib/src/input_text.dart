import 'package:flutter/material.dart'
    show AdaptiveTextSelectionToolbar, materialTextSelectionControls;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_theme/ui_theme.dart';

class UiInputText extends StatefulWidget {
  const UiInputText({
    super.key,
    this.width,
    //this.height,
    this.maxLines = 1,
    this.text,
    this.leading,
    this.action,
    this.hint,
    this.borderSide,
    this.style,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.clear = false,
    this.autofocus = false,
    this.obscureText = false,
    this.padding,
    this.selection,
  });

  final double? width;

  //final double? height;
  final int maxLines;
  final String? text;
  final List<Widget>? leading;
  final List<Widget>? action;
  final String? hint;
  final BorderSide? borderSide;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool clear;
  final bool autofocus;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final bool? selection;

  @override
  State<UiInputText> createState() => _UiInputTextState();
}

class _UiInputTextState extends State<UiInputText> {
  late TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  final defaultTextStyle = TextStyle(
    color: const Color(0xFF333333),
    fontSize: 14.r,
  );

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
      text: widget.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final finalStyle = defaultTextStyle.merge(widget.style);
    return Container(
      padding: EdgeInsets.all(5.r),
      width: widget.width ?? 128.r,
      //height: widget.height ?? 128.r,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: const Color(0xFF9E9E9E)),
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Row(
        spacing: 5.r,
        children: [
          ...?widget.leading,
          Expanded(
            child: EditableText(
              controller: controller,
              focusNode: focusNode,
              obscureText: widget.obscureText,
              style: finalStyle,
              maxLines: widget.maxLines,
              cursorColor: UiTheme.primaryColor,
              backgroundCursorColor: const Color(0xFFEEEEEE),
              selectionColor: UiTheme.primaryColor.withAlpha(50),
              showSelectionHandles: true,
              selectionControls: materialTextSelectionControls,
              contextMenuBuilder: (context, editableTextState) =>
                  AdaptiveTextSelectionToolbar.editableText(
                    editableTextState: editableTextState,
                  ),
            ),
          ),
          ...?widget.action,
        ],
      ),
    );
  }
}
