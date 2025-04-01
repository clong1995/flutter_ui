import 'package:state/event_bus.dart';
import 'package:state/logic.dart';

class _State {}

class EventBusLogic extends Logic<_State> with EventBus {
  EventBusLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
    //过滤特定的event
    setInterested(["event1", "event2"], onEvent);
  }

  @override
  void onEvent(Event event) {
    switch (event.topic) {
      case "event1":
        print(event.message<String>());
        break;
      case "event2":
        final message = event.message<List<int>>();
        if(message != null){
          for(int e in message){
            print(e);
          }
        }
        break;
    }
  }

  void onPublishEvent1Pressed() {
    Event event = "event1".event<String>("hello world");
    publish(event);
  }

  void onPublishEvent2Pressed() {
    Event event = "event2".event<List<int>>([1, 2, 3]);
    publish(event);
  }
}
