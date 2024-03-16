import 'package:state/logic.dart';

//状态数据
class _State{
  int count = 0;
}

//logic和state绑定
class ALogic extends Logic<ALogic, _State> {
  ALogic(super._context){
    super.state = _State();
  }

  void onPressed() {
    state.count += 1;
    update();
  }

  //仅包含两个生命周期函数：onInit和onDispose

  //加载时候执行型一次
  @override
  void onInit() {
    print("onInit");
  }

  //卸载时候释放资源只执行一次
  @override
  void onDispose() {
    print("onDispose");
    super.onDispose();
  }
}