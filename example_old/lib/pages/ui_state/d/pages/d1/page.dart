import 'package:flutter/material.dart';

class D1Page extends StatelessWidget {
  const D1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("D1页面"),
      ),
      body: const Text("D1页面"),
    );
  }
}
