import 'package:flutter/material.dart';
import 'package:state/logic.dart';
import 'package:state/src/logic_dict.dart';

class StateWidget<T extends Logic<dynamic>> extends StatefulWidget {
  // final bool public;

  const StateWidget({
    required this.logic,
    required this.builder,
    super.key,
    // this.public = false,
  });

  final T Function(BuildContext context) logic;
  final Widget Function(BuildContext context, T) builder;

  @override
  State<StateWidget<T>> createState() => _StateWidgetState<T>();
}

class _StateWidgetState<T extends Logic<dynamic>>
    extends State<StateWidget<T>> {
  late T logic;

  @override
  void initState() {
    super.initState();
    logic = widget.logic(context);
    if (logic.public) {
      LogicDict.set<T>(logic);
    }
    logic
      ..initDict(() => setState(() {}))
      ..onInit();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logic.onDidChanged();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, logic);

  @override
  void dispose() {
    logic.onDispose();
    if (logic.public) {
      LogicDict.remove<T>();
    }
    super.dispose();
  }
}
