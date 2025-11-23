import 'package:example/list1/logic.dart';
import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

StateWidget list1Page() => StateWidget<List1Logic>(
  logic: List1Logic.new,
  builder:
      (context, logic) => Scaffold(
        body: Column(
          children: [
            logic.builder(
              key: const ValueKey('item'),
              builder: (c) => Text(logic.state.item),
            ),
            FilledButton(
              onPressed: logic.onLoadItemPressed,
              child: const Text('load item'),
            ),
            FilledButton(
              onPressed: logic.onReloadListPressed,
              child: const Text('reload list'),
            ),
            Column(
              children: logic.state.list.map(Text.new).toList(),
            ),
          ],
        ),
      ),
);
