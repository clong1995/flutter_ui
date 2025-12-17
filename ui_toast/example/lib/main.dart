import 'package:flutter/material.dart';
import 'package:ui_toast/ui_toast.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  UiToast.init(navigatorKey: appNavigatorKey);
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
      navigatorKey: appNavigatorKey,
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
                UiToast.show(UiToastMessage.success());
              },
              child: const Text("success"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToastMessage.info());
              },
              child: const Text("info"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToastMessage.failure());
              },
              child: const Text("failure"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToastMessage.loading());
                Future.delayed(const Duration(seconds: 2), UiToast.dismiss);
              },
              child: const Text("loading"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToastMessage()
                  ..text = '自定义文本'
                  ..icon = const Icon(Icons.back_hand_outlined));
              },
              child: const Text("自定义"),
            ),
            FilledButton(
              onPressed: () {
                UiToast.show(UiToastMessage.failure()
                  ..text = '是否重试'
                  ..choiceCallback = (bool choice) {
                    debugPrint('$choice');
                  });
              },
              child: const Text("选择"),
            ),
          ],
        ),
      ),
    );
  }
}
