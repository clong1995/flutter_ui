import 'package:flutter/material.dart';

import 'widgets/e1/widget.dart';
import 'widgets/e2/widget.dart';

class EPage extends StatelessWidget {
  const EPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("跨组件通信"),
      ),
      body: const Column(
        children: [
          Text("组件之间的相互通信"),
          Text("例子："),
          Column(
            children: [
              E1Widget(),
              Divider(height: 50,),
              E2Widget(),
            ],
          )
        ],
      ),
    );
  }
}
