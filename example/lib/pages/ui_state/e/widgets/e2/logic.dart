import 'package:state/logic.dart';

import '../e1/logic.dart';
class _State {
  int count = 0;
}


class E2Logic extends Logic<_State> {
  E2Logic(super.context) {
    super.state = _State();
  }

  void countAdd() {
    state.count++;
    update(["count"]);
  }

  void onAddPressed() {
    //调用E1组件的加法
    find<E1Logic>()?.countAdd();
  }
}
