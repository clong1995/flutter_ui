import 'package:flutter/material.dart';

import 'logic.dart';
import 'src/logic_dict.dart';

class StateWidget<T extends Logic> extends StatefulWidget {
  final T logic;
  final Widget Function(T) builder;

  const StateWidget({
    super.key,
    required this.logic,
    required this.builder,
  });

  @override
  State<StateWidget<T>> createState() => _StateWidgetState<T>();
}

class _StateWidgetState<T extends Logic> extends State<StateWidget<T>> {
  @override
  void initState() {
    super.initState();
    LogicDict.set<T>(widget.logic);
    //WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {});
    widget.logic.initDict(() => setState(() {}));
    widget.logic.onInit();
  }

  @override
  Widget build(BuildContext context) {
    T? logic = LogicDict.get<T>();
    return logic == null
        ? const Text(
            "logic not found",
            style: TextStyle(color: Colors.red),
          )
        : widget.builder(logic);
  }

  @override
  void dispose() {
    super.dispose();
    LogicDict.get<T>()?.onDispose();
    LogicDict.remove<T>();
  }
}
