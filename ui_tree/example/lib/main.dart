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

  List<UiTreeItem<Data>> data = [
    UiTreeItem()
      ..id = "A"
      ..data = (Data()..title = "A 一级标题"),
    UiTreeItem()
      ..id = "B"
      ..pid = "A"
      ..data = (Data()..title = "B 二级标题"),
    UiTreeItem()
      ..id = "C"
      ..pid = "A"
      ..data = (Data()..title = "C 二级标题"),
    UiTreeItem()
      ..id = "D"
      ..pid = "A"
      ..data = (Data()..title = "D 二级标题"),
    UiTreeItem()
      ..id = "E"
      ..data = (Data()..title = "E 一级标题"),
    UiTreeItem()
      ..id = "F"
      ..pid = "E"
      ..data = (Data()..title = "F 二级标题"),
    UiTreeItem()
      ..id = "G"
      ..pid = "E"
      ..data = (Data()..title = "G 三级标题"),
    UiTreeItem()
      ..id = "H"
      ..pid = "G"
      ..data = (Data()..title = "H 四级标题"),
    UiTreeItem()
      ..id = "I"
      ..pid = "G"
      ..data = (Data()..title = "I 四级标题"),
    UiTreeItem()
      ..id = "J"
      ..data = (Data()..title = "J 一级标题"),
    UiTreeItem()
      ..id = "K"
      ..data = (Data()..title = "K 一级标题"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UiTree<Data>(
        data: data,
        itemBuilder:
            (e, length, level, expand, selected) =>
                itemBuilder(e, length, level, expand, selected),
        onTap: (String id) {
          print(id);
        },
      ),
    );
  }

  Widget itemBuilder(
    Data data,
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
              "${data.title}-$level-$expand-$length",
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
