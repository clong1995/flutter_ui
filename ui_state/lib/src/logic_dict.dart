class LogicDict {
  static final Map<int, dynamic> _logicDict = {};

  static void set<T>(T logic) {
    if (!_contain<T>()) _logicDict[T.hashCode] = logic;
  }

  static T? get<T>() {
    return _logicDict.containsKey(T.hashCode)
        ? _logicDict[T.hashCode] as T
        : null;
  }

  static bool _contain<T>() => _logicDict.containsKey(T.hashCode);

  static void remove<T>() {
    _logicDict.remove(T.hashCode);
  }
}
