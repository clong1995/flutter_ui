import 'package:dependency/dependency.dart';
import 'package:device/logic.dart';
import 'package:flutter/widgets.dart';

Widget deviceWidget() => stateWidget(DeviceLogic.new, _Build.new);

class _Build extends Build<DeviceLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('device'),
      body: Column(
        children: [],
      ),
    );
  }
}
