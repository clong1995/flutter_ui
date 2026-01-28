import 'package:flutter/widgets.dart';

Widget builder (BuildContext context, Widget? child){

  return DefaultTextStyle(
    style: const TextStyle(
      // color: Color(0xFF333333), // 默认文字颜色
      fontSize: 16.0,           // 默认字体大小
    ),
    child: child??const Placeholder(),
  );
}
