import 'package:flutter/material.dart';

import 'logic.dart';
import 'src/logic_dict.dart';

class StateWidget<T extends Logic> extends StatefulWidget {
  final T Function(BuildContext context) logic;
  final Widget Function(BuildContext context, T) builder;
  // final bool public;

  const StateWidget({
    super.key,
    required this.logic,
    required this.builder,
    // this.public = false,
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
    if (logic.public) {
      LogicDict.set<T>(logic);
    }
    logic.initDict(() => setState(() {}));
    logic.onInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logic.onDidChanged();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context,logic);

  @override
  void dispose() {
    logic.onDispose();
    if (logic.public) {
      LogicDict.remove<T>();
    }
    super.dispose();
  }
}
