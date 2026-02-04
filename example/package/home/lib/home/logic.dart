import 'package:dependency/dependency.dart';

class _State {
}

class HomeLogic extends Logic<_State> {
  HomeLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }
}
