library original;

import 'package:flutter/material.dart';

part 'logic.dart';

class OriginalPage extends StatefulWidget {
  const OriginalPage({super.key});

  @override
  State<OriginalPage> createState() => _OriginalPageState();
}

class _OriginalPageState extends State<OriginalPage> with _Logic {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("${state.count}"),
          FilledButton(
            onPressed: onAddPressed,
            child: const Text("加 1"),
          ),
        ],
      ),
    );
  }
}
