import 'package:flutter/material.dart';
import 'package:ui_tree/ui_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RegExp regExp = RegExp(r'_(\d+)x(\d+)\.$');

  List<UiTreeItem<Data>> data = [
    UiTreeItem()
      ..id = "A"
      ..data = (Data()..title = "让对方韬光"),
    UiTreeItem()
      ..id = "B"
      ..pid = "A"
      ..data = (Data()..title = "了皮"),
    UiTreeItem()
      ..id = "C"
      ..pid = "A"
      ..data = (Data()..title = "下次v不"),
    UiTreeItem()
      ..id = "D"
      ..pid = "A"
      ..data = (Data()..title = "让独特"),
    UiTreeItem()
      ..id = "E"
      ..data = (Data()..title = "土肥圆轨"),
    UiTreeItem()
      ..id = "F"
      ..pid = "E"
      ..data = (Data()..title = "为儿童与"),
    UiTreeItem()
      ..id = "G"
      ..pid = "E"
      ..data = (Data()..title = "日发出通过"),
    UiTreeItem()
      ..id = "H"
      ..pid = "G"
      ..data = (Data()..title = "红酒"),
    UiTreeItem()
      ..id = "I"
      ..data = (Data()..title = "哦古hi就"),
    UiTreeItem()
      ..id = "J"
      ..data = (Data()..title = "就哭了"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UiTree<Data>(data: data, itemBuilder: (e) => itemWidget(e)),
    );
  }

  Widget itemWidget(Data data) {
    return Text(data.title);
  }
}

class Data extends UiTreeItem {
  String title = "";
}
