import 'package:flutter/material.dart';
import 'package:ui_alert/ui_alert.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

void main() {
  UiAlert.navigatorKey= appNavigatorKey;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: appNavigatorKey,
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
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
        title: const Text('toast'),
      ),
      body: Column(
        children: [
          //info
          FilledButton(
            onPressed: () async {
              await UiAlert.info(content: 'info');
            },
            child: const Text('info'),
          ),
        ],
      ),
    );
  }
}
