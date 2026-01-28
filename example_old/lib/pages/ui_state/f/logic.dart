import 'package:state/logic.dart';

class _State {
  List<Item> list = [];
}

class FLogic extends Logic<_State> {
  FLogic(super.context);

  @override
  void onInit() {
    super.state = _State();
    print("初始化函数");
    _loadData();
  }

  void _loadData() {
    state.list = [
      Item(id: "a", name: "A"),
      Item(id: "b", name: "B"),
      Item(id: "c", name: "C"),
      Item(id: "d", name: "D"),
      Item(id: "e", name: "E"),
    ];
    update();
  }

  void onDPressed(){
    state.list.firstWhere((element) => element.id == "d").name = "DDD";
    update(["d"]);
  }
}

class Item {
  String id;
  String name;

  Item({
    required this.id,
    required this.name,
  });
}
