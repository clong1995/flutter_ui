import 'package:flutter/material.dart';
import 'package:multi_window/multi_window.dart';

import 'b_page.dart';
import 'c_page.dart';

//窗口传进来的参数
String multiWindowArgs = "";

Future<void> main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  multiWindowArgs = await MultiWindow.ensureInitialized(args);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    late Widget home;

    //根据参数选择显示的页面
    switch (multiWindowArgs) {
      case "B":
        home = const BPage();
        break;
      case "C":
        home = const CPage();
        break;
      default:
        home = Scaffold(
          appBar: AppBar(
            title: const Text("xxxxxxxx"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(
                  onPressed: () {
                    MultiWindow.open(size: const Size(400, 400), arg: "B");
                  },
                  child: const Text("open B page window"),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: () {
                    MultiWindow.open(size: const Size(0, 0), arg: "C");
                  },
                  child: const Text("open C page window"),
                ),
              ],
            ),
          ),
        );
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: home,
    );
  }
}
