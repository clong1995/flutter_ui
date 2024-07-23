import 'logic.dart';
import 'src/logic_dict.dart';

mixin ExposeLogic<T extends Logic> {
  T? get logic => LogicDict.get<T>();
}
