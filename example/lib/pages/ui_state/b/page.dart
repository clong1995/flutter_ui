import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class BPage extends StatelessWidget {
  const BPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("局部刷新"),
      ),
      body: Column(
        children: [
          const Text(
              "为提高性能，只刷新需要变化的部分。\n这些部分往往独立，可以赋予id作为标识，\n或者与业务绑定，会有业务id。"),
          const Text("例子："),
          StateWidget(
            logic: BLogic(context),
            builder: (logic) => Column(
              children: [
                const Text("姓名：王小明"),
                const Text("工作：码农"),
                logic.builder(
                  id: "age", //设置刷新的id标识
                  builder: () => Text("年龄：${logic.state.age}"),
                ),
                logic.builder(
                  id: "salary", //设置刷新的id标识
                  builder: () => Text("薪水：${logic.state.salary}"),
                ),
                ElevatedButton(
                  onPressed: logic.onAgePressed,
                  child: const Text("增加年龄"),
                ),
                ElevatedButton(
                  onPressed: logic.onSalaryPressed,
                  child: const Text("增加薪水"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
