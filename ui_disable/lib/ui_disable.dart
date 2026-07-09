import 'package:flutter/widgets.dart';

class UiDisable extends StatelessWidget {
  const UiDisable({this.disable = true, required this.child, super.key});

  final Widget child;
  final bool disable;

  @override
  Widget build(BuildContext context) => disable
      ? AbsorbPointer(
          child: ColorFiltered(
            colorFilter: const .matrix(<double>[
              0.2126, 0.7152, 0.0722, 0, .25, // 红色通道的新值
              0.2126, 0.7152, 0.0722, 0, .25, // 绿色通道的新值
              0.2126, 0.7152, 0.0722, 0, .25, // 蓝色通道的新值
              0, 0, 0, 1, 0, // Alpha通道保持不变
            ]),
            child: child,
          ),
        )
      : child;
}
