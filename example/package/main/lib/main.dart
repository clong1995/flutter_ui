import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

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
      body: Text('body'),
    );
  }
}
