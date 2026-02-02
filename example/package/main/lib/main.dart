import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

Future<void> mainApp() async {
  await uiApp(
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
      color: Color(0xFF4CAF50),
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

      color: Color(0xFFAF4C4C),
      body: Text('data'),
    );
  }
}
