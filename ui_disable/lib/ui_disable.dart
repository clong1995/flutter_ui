import 'package:flutter/widgets.dart';

class UiDisable extends StatelessWidget {
  const UiDisable({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => AbsorbPointer(
    child: ColorFiltered(
      colorFilter: const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 90, // 红色通道 + 90亮度
        0.2126, 0.7152, 0.0722, 0, 90, // 绿色通道 + 90亮度
        0.2126, 0.7152, 0.0722, 0, 90, // 蓝色通道 + 90亮度
        0, 0, 0, 1, 0,
      ]),
      child: child,
    ),
  );
}
