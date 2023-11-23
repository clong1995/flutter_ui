import 'package:flutter/material.dart';
import 'package:ui_banner/ui_banner.dart';

class UIBannerExample extends StatelessWidget {
  const UIBannerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("banner"),
      ),
      body: const AspectRatio(
        aspectRatio: 1,
        child: UIBanner(
          child: [
            Text("1"),
            Text("2"),
            Text("3"),
            Text("4"),
          ],
        ),
      ),
    );
  }
}
