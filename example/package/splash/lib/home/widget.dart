import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:splash/home/logic.dart';

Widget homeWidget() => stateWidget(HomeLogic.new, _Build.new);

class _Build extends Build<HomeLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      body: Stack(fit: StackFit.expand, children: [ad(), jump()]),
    );
  }

  Widget ad() => Column(
    children: [
      const Spacer(),
      Image.asset(width: 300.r, 'images/splash.png', package: 'splash'),
      const Spacer(),
      Text(
        '© 2005-2025 flutter.ui \nall rights reserved flutter ui',
        textAlign: TextAlign.center,
        style: TextStyle(color: const Color(0xFF9E9E9E), fontSize: 10.r),
      ),
      SizedBox(height: MediaQuery.of(logic.context).padding.bottom + 10.r),
    ],
  );

  Widget jump() => Positioned(
    top: MediaQuery.of(logic.context).padding.top + 10.r,
    right: 15.r,
    child: Container(
      width: 50.r,
      height: 24.r,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFF000000).withAlpha(20),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: logic.builder(
        key: const ValueKey('jump'),
        builder: (context) {
          final seconds = logic.state.seconds;
          return Text(
            "跳过${seconds == 0 ? "" : seconds}",
            style: const TextStyle(color: Color(0xFFFFFFFF)),
          );
        },
      ),
    ),
  );
}
