import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

import 'logic.dart';

class DPage extends StatelessWidget {
  const DPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("路由"),
      ),
      body: Column(
        children: [
          const Text("简化了页面注册到路由和页面跳转的逻辑，兼容原生路由和页面跳转"),
          const Text("例子："),
          StateWidget(
            logic: DLogic.new,
            builder: (logic) => Column(
              children: [
                ElevatedButton(
                  onPressed: logic.onPushD1Pressed,
                  child: const Text("跳转到D1页面"),
                ),
                ElevatedButton(
                  onPressed: logic.onPushD2Pressed,
                  child: const Text("跳转到D2页面并传参数"),
                ),
                ElevatedButton(
                  onPressed: logic.onPushD3Pressed,
                  child: const Text("跳转到D3页面并返回参数"),
                ),
                logic.builder(
                  id: "arg",
                  builder: () => Text("返回的参数:${logic.state.res??""}"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
