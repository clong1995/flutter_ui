import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:page/logic.dart';

Widget pageWidget() => stateWidget(PageLogic.new, _Build.new);

class _Build extends Build<PageLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
       title: const Text('title'),
      appbarAction: Row(
        children: [
          UiIconButton(
            color: Color(0xFFFFFFFF),
            background: false,
            icon: FontAwesomeIcons.arrowsRotate,
            onTap: () {},
          ),
          UiIconButton(
            color: Color(0xFFFFFFFF),
            background: false,
            icon: FontAwesomeIcons.bars,
            onTap: () {},
          ),
        ],
      ),
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
