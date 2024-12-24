class LogicDict {
  //全局logic
  static final Map<int, dynamic> _logicDict = {};

  static void set<T>(T logic) {
    if (!_contain<T>()) {
      _logicDict[T.hashCode] = logic;
    } else {
      throw "$T : ${T.hashCode} : already exists";
    }
  }

  static T? get<T>() => _contain<T>() ? _logicDict[T.hashCode] as T : null;

  static bool _contain<T>() => _logicDict.containsKey(T.hashCode);

  static void remove<T>() => _logicDict.remove(T.hashCode);

  static void removeHashCode(int hashCode) => _logicDict.remove(hashCode);
}
