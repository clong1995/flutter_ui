import 'package:flutter/material.dart';

import 'a/page.dart';
import 'b/page.dart';
import 'c/page.dart';
import 'd/page.dart';
import 'e/page.dart';

class UIStateExample extends StatelessWidget {
  const UIStateExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("状态管理和跨组件通信"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text("基础用法"),
            subtitle: const Text("界面、状态、逻辑分离，生命周期"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const APage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("局部刷新"),
            subtitle: const Text("基于自定义id或业务id的局部刷新"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const BPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("列表中的精准刷新"),
            subtitle: const Text("列表场景下的标准示例"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const CPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("路由"),
            subtitle: const Text("页面跳转、返回、跳转传参、返回传参"),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const DPage(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text("跨组件通信"),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => const EPage(),
                ),
              );
            },
          ),
          const ListTile(
            title: Text("跨页面通信"),
          ),
        ],
      ),
    );
  }
}
