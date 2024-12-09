class FuncDict {
  static final Map<String, Future<Object?> Function(Object?)> _funcDict = {};

  static void set(Map<String, Future<Object?> Function(Object?)> funcDict) {
    if (funcDict.isEmpty) return;

    funcDict.forEach((key, value) {
      if (!_contain(key)) {
        _funcDict[key] = value;
      } else {
        print("global function【$key】duplication");
      }
    });
  }

  static Future<Object?> Function(Object?)? get(String funcName) => _funcDict[funcName];

  static bool _contain(String funcName) => _funcDict.containsKey(funcName);

  static void remove(Iterable<String> funcName){
    if (funcName.isEmpty) return;
    for (var element in funcName) {
      _funcDict.remove(element);
    }
  }
}
