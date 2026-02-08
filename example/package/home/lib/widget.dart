import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:home/logic.dart';

Widget homeWidget() => stateWidget(HomeLogic.new, _Build.new);

class _Build extends Build<HomeLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('flutter ui'),
      body: ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: tile,
        separatorBuilder: (context, index) => SizedBox(
          height: 10.r,
        ),
        itemCount: logic.state.packages.length,
      ),
    );
  }

  Widget tile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => logic.onTileTap(index),
      child: Container(
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: const Color(0xFF9E9E9E)),
        ),
        child: Text(logic.state.packages[index]),
      ),
    );
  }
}
