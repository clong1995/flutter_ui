import 'package:flutter/material.dart';
import 'package:ui_state/state_widget.dart';

import 'logic.dart';

class D2Page extends StatelessWidget {
  const D2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("D2页面"),
      ),
      body: StateWidget(
        logic: D2Logic(context),
        builder: (logic) => Text("收到的参数:${logic.args?.id}"),
      ),
    );
  }
}
