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
        builder: (logic){
          Widget child = logic.builder(
            id: "count",
            builder: () => Text("1:${logic.state.count}"),
          );
          return Column(
            children: [
              /*...["1", "2", "3"].map(
                    (String e) => logic.builder(
                  id: "count",
                  builder: () => Text("$e:${logic.state.count}"),
                ),
              ),*/
              child,
              child,
              child,
              FilledButton(
                onPressed: logic.onAddPressed,
                child: const Text("+1"),
              )
            ],
          );
        },
      ),
    );
  }
}
