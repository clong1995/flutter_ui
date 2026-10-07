import 'package:flutter/widgets.dart';

class UiHover extends StatefulWidget {
  const new({required this.builder, super.key});

  final Widget Function(bool hover) builder;

  @override
  State<UiHover> createState() => _UiHoverState();
}

class _UiHoverState extends State<UiHover> {
  bool hover = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: widget.builder(hover),
  );
}
