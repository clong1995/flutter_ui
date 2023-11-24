import 'package:ui_state/logic.dart';

import 'args.dart';
class D2Logic extends Logic<D2Logic, dynamic> {
  D2Args? args;

  D2Logic(super.context);

  @override
  void onInit() {
    args = arguments<D2Args>();
  }
}