import 'package:dependency/dependency.dart';

class _State {
}

class ButtonLogic extends Logic<_State> {
  ButtonLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }
}
