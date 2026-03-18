import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class Drag extends StatefulWidget {
  final Widget? child;

  const Drag({super.key, this.child});

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> with WindowListener {
  bool isMaximized = false;

  @override
  Widget build(BuildContext context) => DragToMoveArea(
    child: SizedBox.expand(
      child: Row(
        children: [
          widget.child == null
              ? const Spacer()
              : Expanded(child: widget.child!),
          IconButton(
            color: Colors.black,
            onPressed: windowManager.minimize,
            icon: const Icon(Icons.remove, size: 18),
          ),
          const SizedBox(width: 10),
          IconButton(
            color: Colors.black,
            onPressed: windowSize,
            icon: Icon(
              isMaximized ? Icons.filter_none : Icons.crop_din,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          IconButton(
            color: Colors.black,
            onPressed: windowManager.close,
            icon: const Icon(Icons.close, size: 20),
          ),
          const SizedBox(width: 15),
        ],
      ),
    ),
  );

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
  void onWindowMaximize() {
    isMaximized = true;
    setState(() {});
  }

  @override
  void onWindowUnmaximize() {
    isMaximized = false;
    setState(() {});
  }

  Future<void> windowSize() async {
    final maximized = await windowManager.isMaximized();
    maximized ? windowManager.unmaximize() : windowManager.maximize();
    isMaximized = !maximized;
    setState(() {});
  }
}
