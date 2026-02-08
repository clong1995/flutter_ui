import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';
import 'package:toast/logic.dart';

Widget toastWidget() => stateWidget(ToastLogic.new, _Build.new);

class _Build extends Build<ToastLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('toast'),
      body: Center(
        child: Text('body'),
      ),
    );
  }
}
