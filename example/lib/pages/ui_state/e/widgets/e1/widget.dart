import 'package:flutter/material.dart';
import 'package:ui_state/state_widget.dart';

import 'logic.dart';

class E1Widget extends StatelessWidget {
  const E1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: StateWidget(
        logic: E1Logic(context),
        builder: (logic) => Row(
          children: [
            const Text("E1组件 "),
            logic.builder(
              id: "count",
              builder: () => Text("count: ${logic.state.count} "),
            ),
            ElevatedButton(
              onPressed: logic.onAddPressed,
              child: const Text("给E2组件 +1"),
            )
          ],
        ),
      ),
    );
  }
}
