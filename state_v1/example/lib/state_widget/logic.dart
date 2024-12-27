import 'package:state/logic.dart';

class _State {
  int count = 0;
}

class StateWidgetLogic extends Logic<StateWidgetLogic, _State> {
  StateWidgetLogic(super.context);

  @override
  void onInit() {
    state = _State();
  }

  void onAddPressed() {
    state.count += 1;
    update(["count"]);
  }
}
