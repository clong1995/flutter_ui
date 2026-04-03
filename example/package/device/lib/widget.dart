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
        children: [
          UiButton(
            onTap: logic.onInfoTap,
            child: const Text('info'),
          ),
          logic.builder(
            key: const ValueKey('info'),
            builder: (context) => Text('info:${logic.state.info}'),
          ),
          UiButton(
            onTap: logic.onIdTap,
            child: const Text('id'),
          ),
          logic.builder(
            key: const ValueKey('id'),
            builder: (context) => Text('id:${logic.state.id}'),
          ),
        ],
      ),
    );
  }
}
