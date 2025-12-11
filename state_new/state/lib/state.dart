import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Widget stateWidget<L extends Logic<dynamic>>(
  L Function(BuildContext context) logic,
  Build<L> Function(L logic) build,
) => StateWidget(
  logic: logic,
  build: build,
);

class StateWidget<L extends Logic<dynamic>> extends StatefulWidget {
  const StateWidget({required this.build, required this.logic, super.key});

  final L Function(BuildContext context) logic;
  final Build<L> Function(L logic) build;

  @override
  State<StateWidget<L>> createState() => _StateWidgetState<L>();
}

class _StateWidgetState<L extends Logic<dynamic>>
    extends State<StateWidget<L>> {
  late final L logic;

  @override
  void initState() {
    super.initState();
    logic = widget.logic(context);
    logic
      ..setSetState(setState)
      ..onInit();
  }

  @override
  Widget build(BuildContext context) => widget.build(logic).build();

  @override
  void dispose() {
    logic.onDispose();
    super.dispose();
  }
}

abstract class Build<L extends Logic<dynamic>> {
  Build(this.logic);

  @nonVirtual
  final L logic;

  Widget build();
}

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
    _listeners.forEach((ValueKey<dynamic> key, SetState func) {
      if (keys.contains(key)) func.call(() {});
    });
  }

  void onInit() {}

  void onDidChanged() {}

  void onDispose() {}

  @nonVirtual
  void setSetState(SetState setState) {
    _listeners[const ValueKey<dynamic>('_')] = setState;
  }

  final Map<ValueKey<dynamic>, SetState> _listeners = {};

  @nonVirtual
  Widget builder({
    required ValueKey<dynamic> key,
    required Builder builder,
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

typedef SetState = void Function(VoidCallback fn);
typedef Builder = Widget Function(BuildContext context);

class _BuilderWidget extends StatefulWidget {
  const _BuilderWidget({
    required this.builder,
    required this.dispose,
    required this.init,
  });

  final void Function(SetState setState) init;
  final VoidCallback dispose;
  final Builder builder;

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
