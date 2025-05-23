import 'package:flutter/material.dart';

import 'logic.dart';
import 'src/func_dict.dart';
import 'src/logic_dict.dart';

class StateWidget<T extends Logic> extends StatefulWidget {
  final T Function(BuildContext context) logic;
  final Widget Function(T) builder;
  final bool public;
  final void Function(T)? expose;

  const StateWidget({
    super.key,
    required this.logic,
    required this.builder,
    this.expose,
    this.public = true,
  });

  @override
  State<StateWidget<T>> createState() => _StateWidgetState<T>();
}

class _StateWidgetState<T extends Logic> extends State<StateWidget<T>> {
  late T logic;

  @override
  void initState() {
    super.initState();
    logic = widget.logic(context);
    widget.expose?.call(logic);
    if (widget.public) {
      LogicDict.set<T>(logic);
      FuncDict.set(logic.globalFunc());
    }
    logic.initDict(() => setState(() {}));
    logic.onInit();
  }

  @override
  Widget build(BuildContext context) => widget.builder(logic);

  @override
  void dispose() {
    logic.onDispose();
    if (widget.public) {
      FuncDict.remove(logic.globalFunc().keys);
      LogicDict.remove<T>();
    }
    super.dispose();
  }
}
