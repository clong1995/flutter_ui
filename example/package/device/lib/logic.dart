import 'package:dependency/dependency.dart';

class _State {
}

class DeviceLogic extends Logic<_State> {
  DeviceLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }
}
