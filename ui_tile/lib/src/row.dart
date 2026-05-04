import 'package:flutter/widgets.dart';

class UiTileRow extends StatelessWidget {
  const UiTileRow({
    this.titleWidth,
    required this.child,
    required this.title,
    super.key,
  });

  final String title;
  final double? titleWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: titleWidth,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(child: child),
      ],
    );
  }
}
