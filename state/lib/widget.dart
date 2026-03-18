import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:state/logic.dart' show Logic;
import 'package:state/src/widget.dart' show StateWidget;

Widget stateWidget<L extends Logic<dynamic>>(
  L Function(BuildContext context) logic,
  Build<L> Function(L logic) build,
) => StateWidget(
  logic: logic,
  build: build,
);

abstract class Build<L extends Logic<dynamic>> {
  Build(this.logic);

  @nonVirtual
  final L logic;

  Widget build();
}
