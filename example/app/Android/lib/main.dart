import 'package:flutter/material.dart';

void main() {
  runApp(
    const UiApp(
      title: 'Flutter UI',
      home: MyHomePage(),
    ),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('你好 世界！');
  }
}