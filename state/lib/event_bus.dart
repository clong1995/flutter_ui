import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';

import '/lifecycle.dart';

extension StringEvent on String {
  Event event<T>() => Event<T>()..topic = this;
}

class Event<T> {
  //订阅的消息主题
  String topic = "";

  //随同主题的消息负载
  T? load;
}

mixin EventBus on Lifecycle {
  StreamSubscription? _subscription;

  void publish(Event logicEvent) {
    _EventBus().publish(logicEvent);
  }

  void onEvent(Event event) {}

  @override
  void onInit() {
    super.onInit();
    _subscription = _EventBus().subscribe().listen((event) => onEvent(event));
  }

  void setInterested(
    List<String> events,
    void Function(Event event) onEvent,
  ) {
    _subscription?.cancel();
    _subscription = _EventBus().subscribe(events).listen((event) => onEvent(event));
  }

  @override
  void onDispose() {
    super.onDispose();
    _subscription?.cancel();
  }
}

class _EventBus {
  _EventBus._internal();

  static final _EventBus _instance = _EventBus._internal();

  factory _EventBus() => _instance;

  final StreamController<Event> _controller =
      StreamController<Event>.broadcast();

  // 发布事件
  void publish(Event event) {
    if (kDebugMode) {
      print("publish\n topic: ${event.topic}\n load: ${event.load}");
    }
    _controller.add(event);
  }

  // 订阅事件
  Stream<Event> subscribe([List<String>? topics]) => topics == null
      ? _controller.stream
      : _controller.stream.where((event) => topics.contains(event.topic));
}
