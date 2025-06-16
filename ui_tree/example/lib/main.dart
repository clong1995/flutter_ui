import 'package:flutter/material.dart';
import 'package:ui_tree/ui_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  List<UiTreeItem> data = [
    UiTreeItem()
      ..id = "A"
      ..title = "A 一级标题",
    UiTreeItem()
      ..id = "B"
      ..pid = "A"
      ..title = "B 二级标题",
    UiTreeItem()
      ..id = "C"
      ..pid = "A"
      ..title = "C 二级标题",
    UiTreeItem()
      ..id = "D"
      ..pid = "A"
      ..title = "D 二级标题",
    UiTreeItem()
      ..id = "E"
      ..title = "E 一级标题",
    UiTreeItem()
      ..id = "F"
      ..pid = "E"
      ..title = "F 二级标题",
    UiTreeItem()
      ..id = "G"
      ..pid = "E"
      ..title = "G 三级标题",
    UiTreeItem()
      ..id = "H"
      ..pid = "G"
      ..title = "H 四级标题",
    UiTreeItem()
      ..id = "I"
      ..pid = "G"
      ..title = "I 四级标题",
    UiTreeItem()
      ..id = "J"
      ..title = "J 一级标题",
    UiTreeItem()
      ..id = "K"
      ..title = "K 一级标题",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UiTree(
        data: data,
        itemBuilder: itemBuilder,
        onTap: (String id) {
          print(id);
        },
      ),
    );
  }

  Widget itemBuilder(
    BuildContext context,
    String title,
    int length,
    int level,
    bool expand,
    bool selected,
  ) {
    final selectedFontColor = selected ? Colors.white : Colors.black;
    final selectedBackgroundColor = selected ? Colors.red : Colors.transparent;
    return Container(
      decoration: BoxDecoration(color: selectedBackgroundColor),
      child: Row(
        children: [
          if (length != 0)
            Icon(
              expand ? Icons.arrow_drop_down : Icons.arrow_right,
              size: 15,
              color: selectedFontColor,
            ),
          Expanded(
            child: Text(
              "$data-$level-$expand-$length",
              style: TextStyle(color: selectedFontColor),
            ),
          ),
        ],
      ),
    );
  }
}

class Data {
  String title = "";
}
