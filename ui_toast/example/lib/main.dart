import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_toast/toast.dart';

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
      builder: Toast.builder,
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("toast"),
      ),
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton(
              onPressed: () {
                Toast.show(Toast.success);
              },
              child: const Text("success"),
            ),
            FilledButton(
              onPressed: () {
                Toast.show(Toast.info);
              },
              child: const Text("info"),
            ),
            FilledButton(
              onPressed: () {
                Toast.show(Toast.failure);
              },
              child: const Text("failure"),
            ),
            FilledButton(
              onPressed: () {
                Toast.show(Toast.failure..text = "自定义文本:执行错误");
              },
              child: const Text("failure 执行错误"),
            ),
            FilledButton(
              onPressed: () {
                Toast.show(Toast.loading);
                Future.delayed(const Duration(seconds: 2), Toast.dismiss);
              },
              child: const Text("loading"),
            ),
            FilledButton(
              onPressed: () {
                Toast.show(Toast.choice
                  ..callback = (bool choice) {
                    if (kDebugMode) {
                      print(choice);
                    }
                  });
              },
              child: const Text("选择"),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
