import 'package:flutter/material.dart';

class CheckButton<T> extends StatefulWidget {
  const CheckButton({
    required this.title,
    required this.value,
    super.key,
    this.checked = false,
    this.onTap,
  });

  final String title;
  final T value;
  final bool checked;
  final void Function(T)? onTap;

  @override
  State<CheckButton<T>> createState() => _CheckButtonState<T>();
}

class _CheckButtonState<T> extends State<CheckButton<T>> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  void didUpdateWidget(CheckButton<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;
    final Widget child = InkWell(
      onTap: widget.onTap == null
          ? null
          : () {
              checked = !checked;
              widget.onTap!(widget.value);
              setState(() {});
            },
      child: Container(
        constraints: const BoxConstraints(minHeight: 24),
        decoration: BoxDecoration(
          color: checked ? color.withAlpha(25) : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: checked ? color : Colors.grey),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 24,
              alignment: Alignment.center,
              child: checked
                  ? Icon(Icons.check_box, color: color)
                  : const Icon(
                      Icons.check_box_outlined,
                      color: Colors.grey,
                    ),
            ),
            Text(widget.title, style: TextStyle(color: checked ? color : null)),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
    return widget.onTap == null ? Opacity(opacity: .5, child: child) : child;
  }
}
