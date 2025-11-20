import 'package:flutter/cupertino.dart';
import 'package:state/logic.dart';

class _State {
  String data = '';
}

class ListLogic extends Logic<_State> {
  ListLogic(super.context) {
    state = _State();
  }
  @override
  void onInit() {
    super.onInit();
    state.data = 'test item data';
  }

  void onPressed(){
    state.data = 'testtttttt item data';
    update([const ValueKey('item')]);
  }
}
