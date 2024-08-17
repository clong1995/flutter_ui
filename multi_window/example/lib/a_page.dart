import 'package:flutter/material.dart';
import 'package:multi_window/multi_window.dart';

class APage extends StatelessWidget {
  const APage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              onPressed: () {
                MultiWindow.open(size: const Size(400, 400), args: "B");
              },
              child: const Text("open B page window"),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                MultiWindow.open(size: const Size(600, 600), args: "C");
              },
              child: const Text("open C page window"),
            ),
          ],
        ),
      ),
    );
  }
}
