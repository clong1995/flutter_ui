import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:state/logic.dart';

class _State {
  String item = '';
  List<String> list = [];
}

class List1Logic extends Logic<_State> {
  List1Logic(super.context) {
    state = _State();
  }

  @override
  void onInit() {
    super.onInit();
    unawaited(_loadData());
  }

  Future<void> _loadData() async {
    await Future<void>.delayed(const Duration(seconds: 3));
    state.list = <String>['1', '2', '3', '4'];
    update();
  }

  void onLoadItemPressed() {
    state.item = '1234';
    update([const ValueKey('item')]);
  }

  void onReloadListPressed() {
    state.list = <String>['5', '6', '7', '8'];
    update();
  }
}
