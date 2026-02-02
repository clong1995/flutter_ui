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
      title: Text('title 标题'),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            await FnNav.push(SecondPage.new);
          },
          child: Text('to second page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const UiPage(
      title: Text('Second'),
      body: Text('data'),
    );
  }
}
