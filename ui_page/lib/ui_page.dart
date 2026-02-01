import 'package:flutter/widgets.dart';
import 'package:ui_theme/ui_theme.dart';

class UiPage extends StatelessWidget {
  const UiPage({required this.body, this.betweenSpace, super.key});

  final double? betweenSpace;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ColoredBox(
      color: UiTheme.scaffoldBackgroundColor,
      child: Column(
        children: [
          Container(
            color: UiTheme.primaryColor,
            height: padding.top,
          ),
          Row(
            children: [],
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}
