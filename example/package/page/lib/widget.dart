import 'package:dependency/dependency.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:page/logic.dart';

Widget pageWidget() => stateWidget(PageLogic.new, _Build.new);

class _Build extends Build<PageLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
       title: const Text('title'),
      appbarAction: [
        UiIconButton(
          color: const Color(0xFFFFFFFF),
          background: false,
          icon: Icons.arrow_back_ios_rounded,
          onTap: () {},
        ),
        UiIconButton(
          color: const Color(0xFFFFFFFF),
          background: false,
          icon: Icons.more_horiz_rounded,
          onTap: () {},
        ),
      ],
      body: const Center(
        child: Text('body'),
      ),
    );
  }
}
