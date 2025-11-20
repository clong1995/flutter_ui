import 'package:flutter/foundation.dart';
import 'package:state/event_bus.dart';
import 'package:state/logic.dart';

class _State {}

class EventBusLogic extends Logic<_State> with EventBus {
  EventBusLogic(super.context) {
    state = _State();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    //过滤特定的event
    await setInterested(['event1', 'event2'], onEvent);
  }

  @override
  void onEvent(Event<dynamic> event) {
    switch (event.topic) {
      case 'event1':
        debugPrint(event.message<String>());
      case 'event2':
        final message = event.message<List<int>>();
        if (message != null) {
          for (final e in message) {
            debugPrint(e.toString());
          }
        }
    }
  }

  void onPublishEvent1Pressed() {
    final event = 'event1'.event<String>('hello world');
    publish(event);
  }

  void onPublishEvent2Pressed() {
    final event = 'event2'.event<List<int>>([1, 2, 3]);
    publish(event);
  }
}
