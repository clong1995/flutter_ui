import 'package:flutter/material.dart';
import 'package:ui_adapt/ui_adapt.dart';

class UiAdaptBoxExample extends StatelessWidget {
  const UiAdaptBoxExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("table"),
      ),
      body: UiAdapt(
        width: 100,
        height: 100,
        builder: (double scale) {
          return const Text("");
        },
      ),
    );
  }
}
