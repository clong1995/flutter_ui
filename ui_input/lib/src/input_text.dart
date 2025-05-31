import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputText extends StatefulWidget {
  final double? width;
  final double? height;
  final int maxLines;
  final String? text;
  final Widget? prefix;
  final String? hint;
  final BorderSide? borderSide;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool clear;
  final bool autofocus;
  final bool obscureText;

  const InputText({
    super.key,
    this.width,
    this.height,
    this.maxLines = 0,
    this.text,
    this.prefix,
    this.hint,
    this.borderSide,
    this.style,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.clear = false,
    this.autofocus = false,
    this.obscureText = false,
  });

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
  late BorderSide borderSide;
  late TextStyle style;
  late TextEditingController controller;

  double? height;
  int maxLines = 1;
  double vertical = 0;

  bool obscure = false;

  @override
  void initState() {
    super.initState();
    borderSide = widget.borderSide ?? const BorderSide(color: Colors.grey);
    style = widget.style ?? const TextStyle(fontSize: 14);
    height = widget.height ?? 32;
    if (widget.maxLines != 0) {
      maxLines = widget.maxLines;
      vertical = 10;
      height = null;
    }
    obscure = widget.obscureText;
    controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(InputText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != null) {
      controller.text = widget.text!;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    width: widget.width,
    height: height,
    child: TextField(
      controller: controller,
      cursorHeight: (height ?? 24) * .7,
      obscureText: obscure,
      style: style,
      maxLines: maxLines,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged == null
          ? null
          : (String text_) {
              widget.onChanged!(text_);
            },
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        prefixIcon: widget.prefix,
        prefixIconConstraints: const BoxConstraints(),
        enabledBorder: OutlineInputBorder(
          borderSide: borderSide.copyWith(
            color: borderSide.color.withAlpha(127),
          ),
        ),
        focusedBorder: OutlineInputBorder(borderSide: borderSide),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        fillColor: Colors.white,
        hoverColor: Colors.transparent,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(5),
        ),
        hintText: widget.hint,
        hintStyle: widget.hint == null
            ? null
            : const TextStyle(
                color: Color.fromRGBO(153, 153, 153, 1),
                fontSize: 14,
              ),
        suffixIcon: widget.clear
            ? IconButton(
                onPressed: controller.clear,
                icon: const Icon(Icons.clear),
              )
            : widget.obscureText
            ? IconButton(
                onPressed: () {
                  obscure = !obscure;
                  setState(() {});
                },
                icon: Icon(
                  obscure
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 16,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    ),
  );
}
