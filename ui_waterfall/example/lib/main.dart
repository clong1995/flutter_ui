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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final RegExp regExp = RegExp(r'_([\d]+)x([\d]+)\.$');

  List<Data> data = [
    Data()
      ..id = "A"
      ..title = "让对方韬光养晦家哦可，怕了不和你家门口受到如此沸腾v个月不婚"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/1_s_958x1280.png",
    Data()
      ..id = "B"
      ..title = "发图给v要保护你家门口，了皮"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/2_s_598x335.png",
    Data()
      ..id = "C"
      ..title = "下次v不能买"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/3_s_889x500.png",
    Data()
      ..id = "D"
      ..title = "让独特风格也不会进口，v个不和你家门口工笔花鸟"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/4_s_500x750.png",
    Data()
      ..id = "E"
      ..title = "个与hi就哦可怕，土肥圆轨迹过一会就哦可"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/5_s_750x500.png",
    Data()
      ..id = "F"
      ..title = "为儿童与i哦电饭锅后进先出v不能买儿童用户接口的"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/6_s_960x1280.png",
    Data()
      ..id = "G"
      ..title = "日发出通过vu有黄牛揭秘看到，墙上的固定风格"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/7_s_500x332.png",
    Data()
      ..id = "H"
      ..title = "而饿他副古hi就哦可让的法国红酒，他与hi就一他是度和非i就哦分"
      ..image =
          "https://bj-eschool.oss-cn-beijing.aliyuncs.com/test/8_s_690x1227.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UiWaterfall<Data>(
        data: data,
        itemBuilder: (e) => itemWidget(e),
      ),
    );
  }

  Widget itemWidget(Data data) {
    double aspectRatio = 1;
    Match? match = regExp.firstMatch(data.image);
    if (match != null) {
      String? g1 = match.group(1);
      String? g2 = match.group(2);
      if (g1 == null || g2 == null) {
        aspectRatio = 1;
      } else {
        double? width = double.tryParse(g1);
        double? height = double.tryParse(g2);
        if (width == null || height == null) {
          aspectRatio = 1;
        } else {
          aspectRatio = width / height;
        }
      }
    }
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        border: Border.all(color: const Color(0xFF9E9E9E)),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: aspectRatio,
            child: Image.network(data.image, fit: BoxFit.cover),
          ),
          const SizedBox(height: 5),
          Text(data.title),
        ],
      ),
    );
  }
}

class Data extends UiWaterfallItem {
  String image = "";
  String title = "";
}
