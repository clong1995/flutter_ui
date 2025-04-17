import 'package:state/logic.dart';

class _State{
  int age = 18;
  int salary = 10000;
}

class BLogic extends Logic< _State> {
  BLogic(super.context) {
    super.state = _State();
  }

  void onAgePressed(){
    state.age += 1;
    update(["age"]);
  }

  void onSalaryPressed(){
    state.salary += 100;
    update(["salary"]);
  }
}