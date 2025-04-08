import 'package:flutter/material.dart';
import 'package:ui_webview/ui_webview.dart';

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
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UiWebview(
      url: 'https://web-school.hua100.net/captcha',
      register: {
        "verify": verify,
      },
    );
  }

  Future<dynamic> verify(dynamic json) async{
    return true;
  }
}
