import 'package:ui_state/logic.dart';


class D3Logic extends Logic<D3Logic, dynamic> {
  D3Logic(super.context);

  void onPopPressed(){
    pop<String>("bbbb");
  }
}
