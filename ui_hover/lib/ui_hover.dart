import 'package:flutter/widgets.dart';

class UiHover extends StatefulWidget {
  const new({required this.builder, this.onTap, super.key});

  final Widget Function(bool hover) builder;
  final GestureTapCallback? onTap;

  @override
  State<UiHover> createState() => _UiHoverState();
}

class _UiHoverState extends State<UiHover> {
  bool hover = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: widget.onTap == null
        ? SystemMouseCursors.none
        : SystemMouseCursors.click,
    onEnter: (_) => setState(() => hover = true),
    onExit: (_) => setState(() => hover = false),
    child: widget.onTap == null
        ? widget.builder(hover)
        : GestureDetector(onTap: widget.onTap, child: widget.builder(hover)),
  );
}
