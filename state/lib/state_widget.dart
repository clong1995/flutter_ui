import 'package:flutter/material.dart';

import 'logic.dart';
import 'src/func_dict.dart';
import 'src/logic_dict.dart';

class StateWidget<T extends Logic> extends StatefulWidget {
  final T Function(BuildContext context) logic;
  final Widget Function(T) builder;

  const StateWidget({
    super.key,
    required this.logic,
    required this.builder,
  });

  @override
  State<StateWidget<T>> createState() => _StateWidgetState<T>();
}

/*class _StateWidgetState<T extends Logic> extends State<StateWidget<T>> {
  @override
  void initState() {
    super.initState();
    T logic = widget.logic(context);
    LogicDict.set<T>(logic);
    //WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {});
    logic.initDict(() => setState(() {}));
    logic.onInit();
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
    LogicDict.get<T>()?.onDispose();
    LogicDict.remove<T>();
    super.dispose();
  }
}*/

class _StateWidgetState<T extends Logic> extends State<StateWidget<T>> {
  late T logic;

  @override
  void initState() {
    super.initState();
    logic = widget.logic(context);
    LogicDict.set<T>(logic);
    logic.initDict(() => setState(() {}));
    logic.onInit();
    FuncDict.set(logic.globalFunc());
  }

  @override
  Widget build(BuildContext context) => widget.builder(logic);

  @override
  void dispose() {
    logic.onDispose();
    FuncDict.remove(logic.globalFunc().keys);
    LogicDict.remove<T>();
    super.dispose();
  }
}
