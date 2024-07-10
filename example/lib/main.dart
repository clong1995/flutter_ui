import 'package:flutter/material.dart';

import 'pages/ui_state/ui_state.dart';
import 'pages/ui_table.dart';

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
      home: const UiTableExample(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("ui example"),
      ),
      body: ListView(
        children: const [
          ListTile(
            title: Text("banner"),
          ),
          ListTile(
            title: Text("panel"),
          ),
          ListTile(
            title: Text("state"),
          ),
        ],
      ),
    );
  }
}
