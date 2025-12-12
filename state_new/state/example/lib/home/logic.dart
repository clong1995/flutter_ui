import 'package:flutter/material.dart';
import 'package:state/state.dart';

class _State {
  String name = '张三';
  int age = 18;
  int money = 2600;
}

class HomeLogic extends Logic<_State>{
  HomeLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  void onButtonPressed() {
    state.age++;
    update();
  }

  void onButton1Pressed() {
    state.money++;
    update([const ValueKey<dynamic>('builder')]);
  }


  void onEventSend() {
    sendEvent('hello','word');
  }


  @override
  void onEvent(String topic, dynamic message){
    debugPrint(topic);
    debugPrint('$message');
  }
}
