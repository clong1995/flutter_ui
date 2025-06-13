import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class DragWrap extends StatefulWidget {
  final MaterialApp app;

  const DragWrap(this.app, {super.key});

  @override
  State<DragWrap> createState() => _AppState();
}

class _AppState extends State<DragWrap> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowFocus() {
    // Make sure to call once.
    setState(() {});
    // do something
  }

  @override
  Widget build(BuildContext context) => widget.app;
}
