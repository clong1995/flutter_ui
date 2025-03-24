import 'package:state/event_bus.dart';
import 'package:state/logic.dart';

class _State {}

class MyLogic extends Logic<_State> with EventBus {
  MyLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
    //过滤特定的event
    setInterested(["event1", "event2"], onEvent);
  }

  @override
  void onEvent(Event event) {}

  void publishMyEvent() {
    Event event = "event1".event<String>("你好啊");
    publish(event);
  }
}