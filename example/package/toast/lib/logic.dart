import 'package:dependency/dependency.dart';

class _State {
}

class ToastLogic extends Logic<_State> {
  ToastLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }
}
