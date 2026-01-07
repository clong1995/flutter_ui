import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


abstract class Logic<S> {
  Logic(this.context);

  @nonVirtual
  final BuildContext context;

  @nonVirtual
  late final S state;

  @nonVirtual
  void update([List<ValueKey<dynamic>>? keys]) {
    if (keys == null) {
      _listeners[const ValueKey<dynamic>('_')]?.call(() {});
      return;
    }
    _listeners.forEach((ValueKey<dynamic> key, StateSetter func) {
      if (keys.contains(key)) func.call(() {});
    });
  }

  late final StreamSubscription<_Event> _subscription;

  @mustCallSuper
  void onInit() {
    _subscription = _EventBus.instance.stream.listen(
      (_Event event) => onEvent(event.topic, event.message),
    );
  }

  //void onDidChanged() {}

  @mustCallSuper
  void onDispose() {
    unawaited(_subscription.cancel());
  }

  @nonVirtual
  void sendEvent(String topic, [dynamic message]) {
    _EventBus.instance.send(
      _Event()
        ..topic = topic
        ..message = message,
    );
  }

  void onEvent(String topic, dynamic message) {}

  @nonVirtual
  void setSetState(StateSetter setState) {
    _listeners[const ValueKey<dynamic>('_')] = setState;
  }

  final Map<ValueKey<dynamic>, StateSetter> _listeners = {};

  @nonVirtual
  Widget builder({
    required ValueKey<dynamic> key,
    required WidgetBuilder builder,
  }) => _BuilderWidget(
    init: (setState) {
      for (final k in _listeners.keys) {
        if (k == key) {
          //使用hot reload的时候，如果key无效(父Widget改变，位置夸组件移动，会报错是正常的，release模式不会)
          // throw Exception('$key : already exists');
          debugPrint('$key : already exists');
        }
      }
      _listeners[key] = setState;
    },
    builder: builder,
    dispose: () {
      _listeners.remove(key);
    },
  );
}

class _BuilderWidget extends StatefulWidget {
  const _BuilderWidget({
    required this.builder,
    required this.dispose,
    required this.init,
  });

  final void Function(StateSetter setState) init;
  final VoidCallback dispose;
  final WidgetBuilder builder;

  @override
  State<_BuilderWidget> createState() => _BuilderWidgetState();
}

class _BuilderWidgetState extends State<_BuilderWidget> {
  @override
  Widget build(BuildContext context) => widget.builder(context);

  @override
  void initState() {
    super.initState();
    widget.init(setState);
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}

class _EventBus {
  _EventBus._internal();

  static final _EventBus instance = _EventBus._internal();

  final _controller = StreamController<_Event>.broadcast();

  void send(_Event event) => _controller.add(event);

  Stream<_Event> get stream => _controller.stream;
}

class _Event {
  String topic = '';
  dynamic message;
}
