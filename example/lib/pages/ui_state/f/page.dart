import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class FPage extends StatelessWidget {
  const FPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("列表局部刷新"),
      ),
      body: StateWidget(
        logic: FLogic.new,
        builder: (logic) => Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  Item item = logic.state.list[index];
                  return logic.builder(
                    id: item.id,
                    builder: () {
                      print("builder:${item.id}");
                      return Text(item.name);
                    },
                  );
                },
                itemCount: logic.state.list.length,
              ),
            ),
            FilledButton(
              onPressed: logic.onDPressed,
              child: const Text("修改D"),
            ),
          ],
        ),
      ),
    );
  }
}
