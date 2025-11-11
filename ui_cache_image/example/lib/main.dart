import 'package:flutter/material.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final images = [
    "https://jixiao-storage.oss-cn-beijing.aliyuncs.com/avatar/⏝ⅥⅥ⊢∩,U⏡⚶_0_s_512x508.jpg",
    "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
    "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/7.jpeg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          FilledButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text("reload")),
          ...images.map((e) => SizedBox(
                width: 100,
                height: 100,
                child: UiCacheImage(e),
              )),
          /*SizedBox(
            width: 100,
            height: 100,
            child: Image(
              image: UiCacheImageProvider(
                  ),
            ),
          ),*/
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
