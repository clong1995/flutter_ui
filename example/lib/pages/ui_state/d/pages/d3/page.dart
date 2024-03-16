import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class D3Page extends StatelessWidget {
  const D3Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("D3页面"),
      ),
      body: StateWidget(
        logic: D3Logic(context),
        builder: (logic) => ElevatedButton(
          onPressed: logic.onPopPressed,
          child: const Text("返回并传回参数"),
        ),
      ),
    );
  }
}
