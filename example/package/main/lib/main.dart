import 'package:dependency/dependency.dart';
import 'package:flutter/material.dart';

Future<void> mainApp() async {
  await runUiApp(
    title: 'Flutter UI',
    home: MyHomePage(),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPage(
      title: Text('title 标题'),
      body: ColoredBox(
        color: Color(0xFFF44336),
        child: Text('body 内容'),
      ),
    );
  }
}
