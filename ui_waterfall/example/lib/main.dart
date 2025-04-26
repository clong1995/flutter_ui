import 'package:flutter/material.dart';
import 'package:ui_waterfall/ui_waterfall.dart';

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
    return Scaffold(
      body: UiWaterfall<String>(
        data: [
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/1_s_958x1280.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/2_s_598x335.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/3_s_889x500.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/4_s_500x750.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/5_s_750x500.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/6_s_960x1280.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/7_s_500x332.png",
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/8_s_690x1227.png",
        ],
        itemBuilder: (data) => Image.network(data, fit: BoxFit.fitWidth),
      ),
    );
  }
}
