import 'package:flutter/widgets.dart';
import 'package:ui_theme/ui_theme.dart';

class UITileRow extends StatelessWidget {
  const UITileRow({
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
          child: Text(title,style: TextStyle(
            
          ),),
        ),
        Expanded(child: child),
      ],
    );
  }
}
