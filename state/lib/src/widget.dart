
import 'package:flutter/material.dart';
import 'package:state/logic.dart' show Logic;
import 'package:state/state.dart' show Build;

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
