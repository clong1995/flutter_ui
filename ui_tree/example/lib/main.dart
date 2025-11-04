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

  List<UiTreeItem<String>> data = [
    UiTreeItem<String>(id: "A", data: "A 一级标题"),
    UiTreeItem<String>(id: "B", pid: "A", data: "B 二级标题"),
    UiTreeItem<String>(id: "C", pid: "A", data: "C 二级标题"),
    UiTreeItem<String>(id: "D", pid: "A", data: "D 二级标题"),
    UiTreeItem<String>(id: "E", data: "E 一级标题"),
    UiTreeItem<String>(id: "F", pid: "E", data: "F 二级标题"),
    UiTreeItem<String>(id: "G", pid: "E", data: "G 二级标题"),
    UiTreeItem<String>(id: "H", pid: "G", data: "H 三级标题"),
    UiTreeItem<String>(id: "I", pid: "G", data: "I 三级标题"),
    UiTreeItem<String>(id: "J", data: "J 一标题"),
    UiTreeItem<String>(id: "K", data: "K 一级标题"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UiTree<String>(
        data: data,
        itemBuilder: itemBuilder,
        onTap: (UiTreeItem<String> item) {
          print(item.data);
        },
      ),
    );
  }

  Widget itemBuilder(
    BuildContext context,
    UiTreeItem<String> item,
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
              "${item.data}-$level-$expand-$length",
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
