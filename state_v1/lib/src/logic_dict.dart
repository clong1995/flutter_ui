class LogicDict {
  //全局logic
  static final Map<int, dynamic> _logicDict = {};

  static void set<T>(T logic) {
    if (!contain<T>()) {
      _logicDict[T.hashCode] = logic;
    } else {
      //throw "$T : ${T.hashCode} : already exists";
    }
  }

  static T? get<T>() => contain<T>() ? _logicDict[T.hashCode] as T : null;

  static bool contain<T>() => _logicDict.containsKey(T.hashCode);

  static void remove<T>() => _logicDict.remove(T.hashCode);
}
