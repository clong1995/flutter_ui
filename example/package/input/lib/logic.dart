import 'dart:async';

import 'package:dependency/dependency.dart';

class _State {}

class InputLogic extends Logic<_State> {
  InputLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }
}
