import 'package:example/home/logic.dart';
import 'package:flutter/material.dart' hide State;
import 'package:state/state.dart';

Widget homeWidget() => stateWidget(HomeLogic.new, _Build.new);

class _Build extends Build<HomeLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return Scaffold(
      body: Column(
        children: [
          Text(logic.state.name),
          testWidget(),
          buttonWidget(),
          builderWidget(),
          button1Widget(),
          sendEventWidget(),
        ],
      ),
    );
  }

  Widget testWidget() {
    return Text('${logic.state.age}');
  }

  Widget buttonWidget() {
    return FilledButton(
      onPressed: logic.onButtonPressed,
      child: const Text('button'),
    );
  }

  Widget button1Widget() {
    return FilledButton(
      onPressed: logic.onButton1Pressed,
      child: const Text('button1'),
    );
  }

  Widget builderWidget() {
    return logic.builder(
      key: const ValueKey('builder'),
      builder: (context) => Text('${logic.state.money}'),
    );
  }

  Widget sendEventWidget() {
    return FilledButton(
      onPressed: logic.onEventSend,
      child: const Text('send event'),
    );
  }

}
