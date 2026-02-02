import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';


Future<void> mainApp() async {
  await runUiApp(
    title: 'Flutter UI',
    home: MyHomePage(),
  );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return UiPage(
      title: Text('title 标题'),
      /*body: ColoredBox(
        color: Color(0xFFF44336),
        child: Text('body 内容'),
      ),*/
      body:Column(
        children: [
          Text("这里要保持不变",style: TextStyle(
            color: Color(0xFFF44336),
          ),),
          ColorFiltered(
            colorFilter: const ColorFilter.matrix(<double>[
              0.2126, 0.7152, 0.0722, 0, 90,  // 红色通道 + 50亮度
              0.2126, 0.7152, 0.0722, 0, 90,  // 绿色通道 + 50亮度
              0.2126, 0.7152, 0.0722, 0, 90,  // 蓝色通道 + 50亮度
              0,      0,      0,      1, 0,
            ]),
            child: Container(
              color: Color(0xFFF44336),
              child: Text("这段文字和背景都会变灰"),
            ),
          )
        ],
      )
    );
  }
}
