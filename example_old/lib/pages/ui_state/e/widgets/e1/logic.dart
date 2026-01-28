import '../e2/logic.dart';
import 'package:state/logic.dart';

class _State {
  int count = 0;
}

class E1Logic extends Logic<_State> {
  E1Logic(super.context) {
    super.state = _State();
  }

  void countAdd() {
    state.count++;
    update(["count"]);
  }

  void onAddPressed() {
    //调用E2组件的加法
    find<E2Logic>()?.countAdd();
  }
}
