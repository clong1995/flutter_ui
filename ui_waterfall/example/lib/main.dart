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
      body: UiWaterfall<Color>(
        data: [
          UiWaterfallItem(height: 100, data: Colors.red),
          UiWaterfallItem(height: 120, data: Colors.green),
          UiWaterfallItem(height: 90, data: Colors.blue),
          UiWaterfallItem(height: 130, data: Colors.yellow),
          UiWaterfallItem(height: 100, data: Colors.orange),
          UiWaterfallItem(height: 110, data: Colors.pink),
          UiWaterfallItem(height: 120, data: Colors.grey),
          UiWaterfallItem(height: 100, data: Colors.amber),
        ],
        itemBuilder: (data) => Container(color: data),
      ),
    );
  }
}
