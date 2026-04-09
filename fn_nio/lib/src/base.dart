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
}
