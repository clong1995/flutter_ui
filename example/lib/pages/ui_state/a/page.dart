import 'logic.dart';
import 'package:flutter/material.dart';
import 'package:state/state_widget.dart';

class APage extends StatelessWidget {
  const APage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("基础用法"),
      ),
      body: Column(
        children: [
          const Text(
              "界面:page.dart、状态:state、逻辑:logic.dart。\n分离后易于开发维护，代码职责明确，方便组件化。\nlogic.dart:作为控制器，封装所有界面和状态的操作，是跨组件跨界面通信的基础。\nstate:保存与界面变化相关的状态数据，无关数据(不与ui直接关联、不发生任何变化的数据、计算用到的临时变量)不得放置到state.dart文件中。\npage.dart:UI结构编写，轻量和UI直接相关的逻辑。"),
          const Text("例子："),
          //======
          //1:状态组件
          StateWidget(
            //2:绑定logic和ui绑定
            logic: ALogic.new,
            //3:构建UI器
            builder: (logic) => ElevatedButton(
              onPressed: logic.onPressed,
              child: Text("计数器:${logic.state.count}"),
            ),
          ),
          //======
        ],
      ),
    );
  }
}