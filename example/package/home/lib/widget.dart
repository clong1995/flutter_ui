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
      body: ListView(
        children: [
          //page
          //button
        ],
      ),
    );
  }
}
