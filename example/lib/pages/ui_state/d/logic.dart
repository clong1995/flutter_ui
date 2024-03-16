import 'package:state/logic.dart';

import 'pages/d1/page.dart';
import 'pages/d2/args.dart';
import 'pages/d2/page.dart';
import 'pages/d3/page.dart';


class _State {
  String? res;
}

class DLogic extends Logic<DLogic, _State> {
  DLogic(super.context) {
    super.state = _State();
  }

  void onPushD1Pressed() {
    push(() => const D1Page());
  }

  void onPushD2Pressed() {
    push(
      () => const D2Page(),
      D2Args(id: "aaaaa"),
    );
  }

  Future<void> onPushD3Pressed() async {
    state.res = await push<String>(
      () => const D3Page(),
    );
    update(["arg"]);
  }
}
