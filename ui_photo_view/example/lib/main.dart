import 'package:flutter/material.dart';
import 'package:ui_photo_view/ui_photo_view.dart';

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
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: PhotoViewGrid(
        images: [
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/aa.jpg",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/6.jpg",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/5.jpg",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/2.jpg",
        ],
      ),
    );
  }
}
