import 'package:state/event_bus.dart';
import 'package:state/logic.dart';

class _State {}

class EventBusLogic extends Logic<EventBusLogic,_State> with EventBus {
  EventBusLogic(super.context);

  @override
  void onInit() {
    state = _State();
    //过滤特定的event
    setInterested(["event1", "event2"], onEvent);
  }

  @override
  void onEvent(Event event) {
    print(event.topic);
  }

  void publishMyEvent() {
    Event event = "event1".event<String>("你好啊");
    publish(event);
  }
}
