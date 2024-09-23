import 'dart:async';

class LogicEvent {
  String name = "";
}

extension Event on String {
  LogicEvent event() =>
      LogicEvent()
        ..name = this;
}

class LogicEventPublisher {
  LogicEventPublisher._internal();

  static final LogicEventPublisher _instance = LogicEventPublisher._internal();

  static LogicEventPublisher get instance => _instance;

  factory LogicEventPublisher() {
    return _instance;
  }

  final StreamController<LogicEvent> _controller =
  StreamController<LogicEvent>.broadcast();

  // 发布事件
  void publish(LogicEvent event) {
    print("LogicEventPublisher publish event: ${event.name}");
    _controller.add(event);
  }

  // 订阅事件
  Stream<T> subscribe<T extends LogicEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  Stream<LogicEvent> interested(List<String> eventNames) {
    return _controller.stream.where((event) => eventNames.contains(event.name));
  }

  // 关闭流控制器
  void close() {
    _controller.close();
  }
}


