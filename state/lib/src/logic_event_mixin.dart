import 'dart:async';

import 'package:state/lifecycle.dart';
import 'package:state/src/logic_event.dart';

mixin LogicEventMixIn on Lifecycle {
  StreamSubscription? _subscription;
  void publish(LogicEvent logicEvent) {
    LogicEventPublisher.instance.publish(logicEvent);
  }

  void onEvent(LogicEvent event) {}
  void setInteresting(List<String> events,
      [void Function(LogicEvent event)? onEventCallback]) {
    _subscription?.cancel();
    _subscription =
        LogicEventPublisher.instance.interested(events).listen((event) {
      if (onEventCallback != null) {
        onEventCallback(event);
      } else {
        onEvent(event);
      }
    });
  }

  @override
  void onDispose() {
    super.onDispose();
    _subscription?.cancel();
  }
}
