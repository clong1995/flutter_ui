import 'package:flutter/material.dart';
import 'package:ui_panel/ui_panel.dart';

class UIPanelExample extends StatelessWidget {
  const UIPanelExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("panel"),
      ),
      body: const UIPanel(),
    );
  }
}
