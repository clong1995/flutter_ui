import 'package:flutter/material.dart' show Icons;
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_input/ui_input.dart';

class UiInputNumber<T extends num> extends StatefulWidget {
  const UiInputNumber({
    this.num,
    super.key,
    this.width,
    this.onChanged,
    this.autofocus = false,
    this.style,
    this.padding,
    this.decoration,
    this.controller,
  });

  final double? width;
  final T? num;
  final void Function(T)? onChanged;
  final bool autofocus;
  final TextStyle? style;
  final EdgeInsets? padding;
  final BoxDecoration? decoration;
  final TextEditingController? controller;

  @override
  State<UiInputNumber<T>> createState() => _UiInputNumberState<T>();
}

class _UiInputNumberState<T extends num> extends State<UiInputNumber<T>> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    late RegExp reg;
    if (T == int) {
      reg = RegExp(r'[0-9\-]');
    } else if (T == double) {
      reg = RegExp(r'[0-9.\-]');
    }
    final number = widget.num ?? 0 as T;

    return UiInputText(
      text: '$number',
      textAlign: TextAlign.center,
      spacing: 0,
      width: widget.width ?? 90.r,
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 5.r),
      style: widget.style,
      autofocus: widget.autofocus,
      decoration: widget.decoration,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(reg)],
      controller: controller,
      onChanged: widget.onChanged == null ? null : onInputChanged,
      leading: [
        UiIconButton(
          background: false,
          onTap: widget.onChanged == null ? null : onSubtractPressed,
          icon: Icons.remove,
        ),
      ],
      action: [
        UiIconButton(
          background: false,
          onTap: widget.onChanged == null ? null : onPlusPressed,
          icon: Icons.add,
        ),
      ],
    );
  }

  @override
  void dispose() {
    if(widget.controller == null){
      controller.dispose();
    }
    super.dispose();
  }

  T? numberParse() {
    num? n;
    final text = controller.text;
    if (text.isEmpty) {
      return null;
    } else {
      n = num.tryParse(text);
      if (n == null) {
        return null;
      }
    }

    if (T == int) {
      if (n is double) {
        n = n.toInt();
      }
    } else if (T == double) {
      if (n is int) {
        n = n.toDouble();
      }
    } else {
      return null;
    }

    return n as T;
  }

  void onSubtractPressed() {
    final n = numberParse();
    if (n == null) {
      return;
    }
    controller.text = '${n - 1}';
    widget.onChanged!((n - 1) as T);
  }

  void onPlusPressed() {
    final n = numberParse();
    if (n == null) {
      return;
    }
    controller.text = '${n + 1}';
    widget.onChanged!((n + 1) as T);
  }

  void onInputChanged(String text) {
    if (text == '-') {
      return;
    }
    final n = numberParse();
    if (n == null) {
      return;
    }
    widget.onChanged!(n);
  }
}
