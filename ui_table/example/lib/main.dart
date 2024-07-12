import 'package:flutter/material.dart';
import 'package:ui_table/ui_table.dart';

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const List<double> cellsWidth = [
      200,
      150,
      150,
      150,
      150,
      150,
      150,
      150,
      150,
      100,
    ];

    List<List<Widget>> data = [
      const [
        Text("姓名"),
        Text("第一列"),
        Text("第二列"),
        Text("第三列"),
        Text("第四列"),
        Text("第五列"),
        Text("第六列"),
        Text("第七列"),
        Text("第八列"),
        Text("操作"),
      ],
      ...List.generate(30, (int index) {
        return const [
          Text("王小明"),
          Text("B"),
          Text("C"),
          Text("D"),
          Text("E"),
          Text("F"),
          Text("G"),
          Text("H"),
          Text("I"),
          Text("操作"),
        ];
      }),
    ];

    return Scaffold(
      body: UiTable(
        cellsWidth: cellsWidth,
        data: data,
      ),
    );
  }
}
