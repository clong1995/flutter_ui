import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class EventBusPage extends StatelessWidget {
  const EventBusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("test"),
      ),
      body: StateWidget(
          logic: EventBusLogic.new,
          builder: (logic) {
            return const Text("data");
          }),
    );
  }
}
