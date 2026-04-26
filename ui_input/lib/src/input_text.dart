import 'package:flutter/material.dart'
    show AdaptiveTextSelectionToolbar, Icons, materialTextSelectionControls;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

class UiInputText extends StatefulWidget {
  const UiInputText({
    super.key,
    this.width,
    this.maxLines = 1,
    this.text,
    this.leading,
    this.action,
    this.hint,
    this.style,
    this.keyboardType,
    this.inputFormatters,
    this.decoration,
    this.padding,
    this.autofocus = false,
    this.obscureText = false,
    this.onChanged,
    this.controller,
    this.clear = false,
    this.spacing,
    this.textAlign,
  });

  final double? width;
  final double? spacing;
  final int maxLines;
  final String? text;
  final List<Widget>? leading;
  final List<Widget>? action;
  final String? hint;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool clear;
  final bool autofocus;
  final bool obscureText;
  final BoxDecoration? decoration;
  final EdgeInsets? padding;
  final TextEditingController? controller;
  final TextAlign? textAlign;

  @override
  State<UiInputText> createState() => _UiInputTextState();
}

class _UiInputTextState extends State<UiInputText> {
  late TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  late EdgeInsets padding;

  bool obscure = true;

  final defaultDecoration = BoxDecoration(
    color: UiTheme.white,
    border: Border.all(color: UiTheme.gary),
    borderRadius: BorderRadius.circular(5.r),
  );

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = widget.text ?? '';
    padding =
        widget.padding ?? EdgeInsets.symmetric(horizontal: 8.r, vertical: 5.r);
    return Container(
      padding: padding,
      width: widget.width ?? 128.r,
      height: height(),
      decoration: decoration(),
      child: Row(
        spacing: widget.spacing ?? 5.r,
        children: [
          ...?widget.leading,
          Expanded(
            child: widget.hint != null ? hint() : editableText(),
          ),
          if (widget.clear) close(),
          ...?widget.action,
          if (widget.obscureText)
            UiIconButton(
              background: false,
              icon: obscure ? Icons.visibility_off_outlined : Icons.visibility,
              color: obscure ? UiTheme.gary : null,
              size: 12.r,
              onTap: () {
                obscure = !obscure;
                setState(() {});
              },
            ),
        ],
      ),
    );
  }

  Widget hint() => Stack(
    children: [
      ValueListenableBuilder<TextEditingValue>(
        valueListenable: controller,
        builder: (_, value, _) {
          return value.text.isEmpty
              ? Text(
                  widget.hint!,
                  style: textStyle().copyWith(
                    color: textStyle().color?.withAlpha(100) ?? UiTheme.gary,
                    fontWeight: FontWeight.normal,
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
      editableText(),
    ],
  );

  Widget close() => ValueListenableBuilder<TextEditingValue>(
    valueListenable: controller,
    builder: (_, value, _) {
      return value.text.isEmpty
          ? const SizedBox.shrink()
          : UiIconButton(
              background: false,
              icon: Icons.highlight_remove_outlined,
              onTap: () {
                controller.clear();
                widget.onChanged?.call('');
              },
            );
    },
  );

  Widget editableText() => EditableText(
    textAlign: widget.textAlign ?? TextAlign.start,
    autofocus: widget.autofocus,
    keyboardType: widget.keyboardType,
    inputFormatters: widget.inputFormatters,
    controller: controller,
    focusNode: focusNode,
    readOnly: widget.onChanged == null,
    obscureText: widget.obscureText && obscure,
    style: textStyle(),
    maxLines: widget.maxLines,
    cursorColor: UiTheme.primaryColor,
    backgroundCursorColor: UiTheme.gary200,
    showSelectionHandles: true,
    selectionControls: materialTextSelectionControls,
    contextMenuBuilder: (context, editableTextState) =>
        AdaptiveTextSelectionToolbar.editableText(
          editableTextState: editableTextState,
        ),
    onChanged: widget.onChanged,
  );

  double height() =>
      padding.top +
      padding.bottom +
      widget.maxLines *
          (textStyle().fontSize ?? 14.r) *
          (textStyle().height ?? 1.25) +
      (decoration().border?.top.width ?? 1) * 2;

  BoxDecoration decoration() {
    if (widget.decoration == null) {
      return defaultDecoration;
    }
    return widget.decoration!.copyWith(
      color: widget.decoration!.color ?? defaultDecoration.color,
      border: widget.decoration!.border ?? defaultDecoration.border,
      borderRadius:
          widget.decoration!.borderRadius ?? defaultDecoration.borderRadius,
    );
  }

  TextStyle textStyle() => DefaultTextStyle.of(context).style
      .merge(
        TextStyle(
          fontSize: 14.r,
        ),
      )
      .merge(widget.style);
}
