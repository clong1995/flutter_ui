import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:page/logic.dart';

Widget pageWidget() => stateWidget(PageLogic.new, _Build.new);

class _Build extends Build<PageLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return const UiPage(
      title: Text('title'),
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
