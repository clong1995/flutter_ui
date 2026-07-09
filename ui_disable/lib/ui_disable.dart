import 'package:flutter/widgets.dart';

class UiDisable extends StatelessWidget {
  const UiDisable({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => AbsorbPointer(
    child: ColorFiltered(
      colorFilter: const .matrix(<double>[
        0.2126, 0.7152, 0.0722, 0, 0, // 红色通道的新值
        0.2126, 0.7152, 0.0722, 0, 0, // 绿色通道的新值
        0.2126, 0.7152, 0.0722, 0, 0, // 蓝色通道的新值
        0,      0,      0,      1, 0, // Alpha通道保持不变
      ]),
      child: child,
    ),
  );
}
