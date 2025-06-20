import 'package:flutter/material.dart';
import 'package:ui_map/ui_map.dart';
// import 'package:ui_map/region.dart';

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
        useMaterial3: true,
      ),
      home: const MyHomePage(),
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
    /*return Scaffold(
      body: Center(
        child: FilledButton(
          onPressed: () {
            region(context);
          },
          child: Text("选择城市"),
        ),
      ),
    );*/
    return MapView();
  }
}
