//请求数据基类
class BaseReq {
  int t = 0;
  String a = '';

  Map<String, dynamic> toJson() {
    return {'t': t, 'a': a};
  }
}

//返回数据基类
abstract class BaseRes {
  String state = 'ERROR';
  Map<String, dynamic> data = {};

  //解析json字符串
  void fromJson();

  String asString(dynamic value, [String def = '']) =>
      (value is String) ? value : def;

  int asInt(dynamic value, [int def = 0]) => (value is int) ? value : def;

  double asDouble(dynamic value, [double def = 0]) =>
      (value is double) ? value : def;

  bool asBool(dynamic value, [bool def = false]) =>
      (value is bool) ? value : def;

  List<String> asListString(dynamic value) =>
      (value is List) ? value.map(asString).toList() : <String>[];

  List<int> asListInt(dynamic value) =>
      (value is List) ? value.map(asInt).toList() : <int>[];

  Map<String, dynamic> asMap(dynamic value) =>
      (value is Map<String, dynamic>) ? value : <String, dynamic>{};

  List<dynamic> asList(dynamic value) =>
      (value is List<dynamic>) ? value : <dynamic>[];
}
