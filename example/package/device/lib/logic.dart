import 'package:dependency/dependency.dart';
import 'package:flutter/foundation.dart';

class _State {
  String info = '';
  String id = '';
}

class DeviceLogic extends Logic<_State> {
  DeviceLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  Future<void> onInfoTap() async {
    final info = await FnDevice.info;
    state.info = info;
    update([const ValueKey('info')]);
  }

  Future<void> onIdTap() async {
    final id = await FnDevice.guid;
    state.id = id;
    update([const ValueKey('id')]); //dbdf-3771-cde6-d4df-416d-4b31-f801-b28d
  }
}
