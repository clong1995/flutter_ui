import 'package:flutter/material.dart';
import 'package:multi_window/multi_window.dart';

import 'a_page.dart';
import 'b_page.dart';
import 'c_page.dart';

//窗口传进来的参数
String? multiWindowArgs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  multiWindowArgs = await MultiWindow.ensureInitialized(4567);
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
        home = const APage();
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





