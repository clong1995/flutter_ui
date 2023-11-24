import 'dart:async';

import 'package:ui_state/logic.dart';

class _State {
  List<Item> list = [];
}

class Item {
  String id;
  String name;
  int salary;

  Item({
    required this.id,
    required this.name,
    required this.salary,
  });
}

class CLogic extends Logic<CLogic, _State> {
  CLogic(super.context) {
    super.state = _State();
  }

  @override
  void onInit() {
    loadData();
  }

  //加载数据
  void loadData() {
    //模拟异步请求网络数据
    Timer(const Duration(seconds: 1), () {
      state.list = [
        Item(id: "aaa", name: "赵老师", salary: 2000),
        Item(id: "bbb", name: "钱老师", salary: 2000),
        Item(id: "ccc", name: "孙老师", salary: 2000),
        Item(id: "ddd", name: "李老师", salary: 2000),
        Item(id: "eee", name: "周老师", salary: 2000),
        Item(id: "fff", name: "吴老师", salary: 2000),
        Item(id: "ggg", name: "郑老师", salary: 2000),
        Item(id: "hhh", name: "王老师", salary: 2000),
        Item(id: "iii", name: "冯老师", salary: 2000),
        Item(id: "jjj", name: "陈老师", salary: 2000),
        Item(id: "kkk", name: "褚老师", salary: 2000),
        Item(id: "lll", name: "卫老师", salary: 2000),
        Item(id: "mmm", name: "蒋老师", salary: 2000),
        Item(id: "nnn", name: "沈老师", salary: 2000),
        Item(id: "ooo", name: "韩老师", salary: 2000),
        Item(id: "ppp", name: "杨老师", salary: 2000),
      ];
      update();
    });
  }

  //增加一个Tom老师
  void onAddPressed() {
    if (state.list.indexWhere((element) => element.id == "tom") == -1) {
      state.list.add(Item(id: "tom", name: "Tom", salary: 2000));
      update();
    }
  }

  //删除
  void onRemovePressed(String id) {
    state.list.removeWhere((element) => element.id == id);
    update();
  }

  //加薪水
  void onModifyPressed(String id) {
    state.list.firstWhere((element) => element.id == id).salary += 100;
    update([id]);
  }
}
