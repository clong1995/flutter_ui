import 'dart:async';

import 'package:flutter/foundation.dart';

import '/lifecycle.dart';

extension StringEvent on String {
  Event event<T>([T? message]) => Event<T>(this,message);
}

class Event<T> {
  //订阅的消息主题
  final String _topic;

  //随同主题的消息负载
  final T? _message;

  Event(this._topic, this._message);

  //T? get message => _message;

  E? message<E>() => _message as E;

  String get topic => _topic;

}

mixin EventBus on Lifecycle {
  late  StreamSubscription _subscription;

  void publish(Event logicEvent) {
    _EventBus().publish(logicEvent);
  }

  void onEvent(Event event) {}

  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    _subscription = _EventBus().subscribe().listen((event) => onEvent(event));
  }

  void setInterested(
    List<String> events,
    void Function(Event event) onEvent,
  ) {
    _subscription.cancel();
    _subscription =
        _EventBus().subscribe(events).listen((event) => onEvent(event));
  }

  @mustCallSuper
  @override
  void onDispose() {
    super.onDispose();
    _subscription.cancel();
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
      print("┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓");
      print("┃ event bus publish:");
      print("┃ topic: ${event.topic}");
      print("┃ message: ${event.message()}");
      print("┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛");
    }
    _controller.add(event);
  }

  // 订阅事件
  Stream<Event> subscribe([List<String>? topics]) => topics == null
      ? _controller.stream
      : _controller.stream.where((event) => topics.contains(event.topic));
}
