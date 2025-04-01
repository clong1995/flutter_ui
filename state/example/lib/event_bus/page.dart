import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

StateWidget eventBusPage() => StateWidget<EventBusLogic>(
  logic: EventBusLogic.new,
  builder:
      (logic) => Scaffold(
        body: Column(
          mainAxisAlignment : MainAxisAlignment. center,
          children: [
            FilledButton(
              onPressed: logic.onPublishEvent1Pressed,
              child: const Text("发布事件1"),
            ),
            FilledButton(
              onPressed: logic.onPublishEvent2Pressed,
              child: const Text("发布事件2"),
            ),
          ],
        ),
      ),
);
