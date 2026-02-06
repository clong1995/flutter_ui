import 'package:dependency/dependency.dart';

class _State {
}

class PageLogic extends Logic<_State> {
  PageLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }
}
