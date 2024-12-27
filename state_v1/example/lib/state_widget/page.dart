import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class StateWidgetPage extends StatelessWidget {
  const StateWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StateWidget(
        logic: StateWidgetLogic.new,
        builder: (logic) => Column(
          children: [
            logic.builder(
              id: "count",
              builder: () => Text("${logic.state.count}"),
            ),
            FilledButton(
              onPressed: logic.onAddPressed,
              child: const Text("+1"),
            )
          ],
        ),
      ),
    );
  }
}
