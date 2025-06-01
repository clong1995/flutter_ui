import 'package:flutter/material.dart';

class CheckButton extends StatefulWidget {
  final String title;
  final bool checked;
  final void Function(bool)? onTap;

  const CheckButton({
    super.key,
    required this.title,
    this.checked = false,
    this.onTap,
  });

  @override
  State<CheckButton> createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  bool checked = false;

  @override
  void initState() {
    super.initState();
    checked = widget.checked;
  }

  @override
  void didUpdateWidget(CheckButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    checked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    Container child = Container(
      constraints: const BoxConstraints(minHeight: 24),
      decoration: BoxDecoration(
        color: checked ? color.withAlpha(25) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: checked ? color : Colors.grey),
      ),
      child: InkWell(
        onTap:
            widget.onTap == null
                ? null
                : () {
                  checked = !checked;
                  widget.onTap!(checked);
                  setState(() {});
                },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 24,
              alignment: Alignment.center,
              child:
                  checked
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
