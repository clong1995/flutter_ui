import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:state/lifecycle.dart';

extension StringEvent on String {
  Event<T> event<T>([T? message]) => Event<T>(this, message);
}

class Event<T> {
  Event(this._topic, this._message);

  //订阅的消息主题
  final String _topic;

  //随同主题的消息负载
  final T? _message;

  //T? get message => _message;

  E? message<E>() => _message == null ? null : _message as E;

  String get topic => _topic;

  @override
  String toString() {
    return 'Event{topic: $_topic, message: $_message}';
  }
}

mixin EventBus on Lifecycle {
  late StreamSubscription<Event<dynamic>> _subscription;

  @nonVirtual
  void publish(Event<dynamic> event) {
    _EventBus().publish(event);
  }

  void onEvent(Event<dynamic> event) {}

  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    _subscription = _EventBus().subscribe().listen(onEvent);
  }

  @nonVirtual
  Future<void> setInterested(
    List<String> events,
    void Function(Event<dynamic> event) onEvent,
  ) async {
    await _subscription.cancel();
    _subscription = _EventBus().subscribe(events).listen(onEvent);
  }

  @mustCallSuper
  @override
  void onDispose() {
    super.onDispose();
    unawaited(_subscription.cancel());
  }
}

class _EventBus {
  factory _EventBus() => _instance;

  _EventBus._internal();

  static final _EventBus _instance = _EventBus._internal();

  final StreamController<Event<dynamic>> _controller =
      StreamController<Event<dynamic>>.broadcast();

  // 发布事件
  void publish(Event<dynamic> event) {
    debugPrint(
      '┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓',
    );
    debugPrint('┃ event bus publish:');
    debugPrint('┃ $event');
    debugPrint(
      '┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛',
    );

    _controller.add(event);
  }

  // 订阅事件
  Stream<Event<dynamic>> subscribe([List<String>? topics]) => topics == null
      ? _controller.stream
      : _controller.stream.where((event) => topics.contains(event.topic));
}
