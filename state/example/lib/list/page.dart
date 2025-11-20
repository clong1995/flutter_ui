import 'package:example/list/logic.dart';
import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

StateWidget listPage() => StateWidget<ListLogic>(
  logic: ListLogic.new,
  builder:
      (context, logic) => Scaffold(
        body: Column(
          children: [
            const Text('ABC'),
            //item(logic),
            Column(
              children: [
                Item1Widget(key: const ValueKey('item1'), data: logic.state.data),
                Text('${DateTime.now()}'),
              ],
            ),
            const Text('DEF'),
            FilledButton(onPressed: logic.onPressed, child: const Text('update'))
          ],
        ),
      ),
);

Widget item(ListLogic logic) => logic.builder(
  //id: 'item',
  key: const ValueKey('item'),
  builder: (context) {
    return Text('logic state data: ${logic.state.data}');
  },
);

class Item1Widget extends StatefulWidget {
  const Item1Widget({required this.data, super.key});

  final String data;

  @override
  State<Item1Widget> createState() => _Item1WidgetState();
}

class _Item1WidgetState extends State<Item1Widget> {
  @override
  void initState() {
    super.initState();
    print('========initState');
  }

  @override
  void dispose() {
    print('========dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.data);
  }
}
