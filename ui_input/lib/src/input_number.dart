import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputNumber<T extends num> extends StatefulWidget {
  final double? width;
  final double? height;
  final T num;
  final void Function(T)? onChanged;
  final bool autofocus;
  final TextStyle? style;

  const InputNumber({
    super.key,
    this.width,
    this.height,
    required this.num,
    this.onChanged,
    this.autofocus = false,
    this.style,
  });

  @override
  State<InputNumber<T>> createState() => _InputNumberState<T>();
}

class _InputNumberState<T extends num> extends State<InputNumber<T>>
    with WidgetsBindingObserver {
  late TextEditingController controller;

  late RegExp reg;
  late double height;
  late double width;
  late TextStyle style;

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (widget.num is int) {
      reg = RegExp(r'[0-9\-]');
    } else if (widget.num is double) {
      reg = RegExp(r'[0-9.\-]');
    }

    height = widget.height ?? 32;
    width = widget.width ?? 85;
    style = widget.style ?? const TextStyle(fontSize: 14);
    controller = TextEditingController(text: "${widget.num}");
  }

  @override
  void didChangeMetrics() {
    final bottomInset =
        WidgetsBinding
            .instance
            .platformDispatcher
            .views
            .first
            .viewInsets
            .bottom;
    bool isKeyboardVisible = bottomInset > 0;

    if (!isKeyboardVisible && focusNode.hasFocus) {
      focusNode.unfocus();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    controller.text = "${widget.num}";
  }

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      children: [
        IconButton(
          onPressed: widget.onChanged == null ? null : onSubtractPressed,
          icon: const Icon(Icons.remove),
        ),
        Expanded(
          child: TextField(
            textAlign: TextAlign.center,
            controller: controller,
            cursorHeight: height * .7,
            style: style,
            maxLines: 1,
            focusNode: focusNode,
            readOnly: widget.onChanged == null,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(reg)],
            onChanged: widget.onChanged == null ? null : onInputChanged,
            autofocus: widget.autofocus,
            decoration: const InputDecoration(
              prefixIconConstraints: BoxConstraints(),
              contentPadding: EdgeInsets.zero,
              fillColor: Colors.white,
              hoverColor: Colors.transparent,
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide.none),
            ),
          ),
        ),
        IconButton(
          onPressed: widget.onChanged == null ? null : onPlusPressed,
          icon: const Icon(Icons.add),
        ),
      ],
    ),
  );

  T? get number {
    num? n;
    String text = controller.text;
    if (text.isEmpty) {
      return null;
    } else {
      n = num.tryParse(text);
      if (n == null) {
        return null;
      }
    }

    if (widget.num is int) {
      if (n is double) {
        n = n.toInt();
      }
    } else if (widget.num is double) {
      if (n is int) {
        n = n.toDouble();
      }
    } else {
      return null;
    }

    return n as T;
  }

  void onSubtractPressed() {
    T? n = number;
    if (n == null) {
      return;
    }
    controller.text = "${n - 1}";
    widget.onChanged!((n - 1) as T);
  }

  void onPlusPressed() {
    T? n = number;
    if (n == null) {
      return;
    }
    controller.text = "${n + 1}";
    widget.onChanged!((n + 1) as T);
  }

  void onInputChanged(String text) {
    if (text == "-") {
      return;
    }
    T? n = number;
    if (n == null) {
      return;
    }
    widget.onChanged!(n);
  }
}
