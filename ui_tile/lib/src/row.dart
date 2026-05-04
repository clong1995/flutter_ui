import 'package:flutter/widgets.dart';

class UiTileRow extends StatelessWidget {
  const UiTileRow({
    required this.title,
    this.child,
    this.action,
    this.titleWidth,
    super.key,
  });

  final String title;
  final double? titleWidth;
  final Widget? child;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (child == null) const Spacer() else Expanded(child: child!),
        ?action,
      ],
    );
  }
}
