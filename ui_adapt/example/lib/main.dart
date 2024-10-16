import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_adapt/ui_adapt.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
    int count = 68;

    Size size = MediaQuery.of(context).size;

    double containerWidth = size.width;
    double containerHeight = size.height;

    double bestEdge = 0.0;
    int numSquares = 0;

    for (double edge = 1.0;
        edge <= min(containerWidth, containerHeight);
        edge++) {
      int countInWidth = (containerWidth / edge).floor(); // 水平方向的数量
      int countInHeight = (containerHeight / edge).floor(); // 垂直方向的数量
      numSquares = countInWidth * countInHeight; // 总数量

      if (numSquares >= count) {
        bestEdge = edge;
      }
    }

    // 输出结果
    if (bestEdge > 0) {
      numSquares = ((containerWidth / bestEdge).floor()) *
          ((containerHeight / bestEdge).floor());
    }

    return Scaffold(
      body: UiAdapt(
        width: containerWidth,
        height: containerHeight,
        builder: (double scale) {
          return Wrap(
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children:
                  List.generate(numSquares, (index) => index).map((int e) {
                return Container(
                  color: e > count ? Colors.grey : Colors.red,
                  width: bestEdge,
                  height: bestEdge,
                );
              }).toList());
        },
      ),
    );
  }
}
