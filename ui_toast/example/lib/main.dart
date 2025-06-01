import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ui_toast/ui_toast.dart';

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
      builder: uiToastBuilder,
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
                UiToast.show(UiToast.success);
              },
              child: const Text("success"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToast.info);
              },
              child: const Text("info"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToast.failure);
              },
              child: const Text("failure"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToast.failure..text = "自定义文本:执行错误");
              },
              child: const Text("failure 执行错误"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToast.loading);
                Future.delayed(const Duration(seconds: 2), UiToast.dismiss);
              },
              child: const Text("loading"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToast.choice
                  ..choiceCallback = (bool choice) {
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
