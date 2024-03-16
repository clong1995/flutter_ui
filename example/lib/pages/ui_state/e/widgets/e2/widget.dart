import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class E2Widget extends StatelessWidget {
  const E2Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.green,
        child: StateWidget(
          logic: E2Logic(context),
          builder: (logic) =>
              Row(
                children: [
                  const Text("E2组件 "),
                  logic.builder(
                    id: "count",
                    builder: () => Text("count: ${logic.state.count} "),
                  ),
                  ElevatedButton(
                    onPressed: logic.onAddPressed,
                    child: const Text("给E1组件 +1"),
                  )
                ],
              ),
        ),
    );
  }
}
