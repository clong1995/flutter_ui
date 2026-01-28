import 'package:flutter/widgets.dart';
import 'package:ui_app/ui_app.dart';

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
    return const Text('xxx');
  }
}
