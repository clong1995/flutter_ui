import 'dart:async';
import 'dart:convert';

import 'package:fn_auth/fn_auth.dart';
import 'package:fn_nio/src/host.dart';
import 'package:fn_security/fn_security.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:ui_toast/ui_toast.dart';

Client _client = Client();

Future<Map<String, dynamic>> send(String uri, String jsonString) async {
  //loading
  void Function()? toastPop;
  final timer = Timer(const Duration(seconds: 3), () {
    toastPop = UiToast.show(UiToastMessage.loading());
  });

  //请求地址
  final url = Uri.parse(getHost() + uri);

  //返回结果
  final res = <String, dynamic>{'state': ''};

  final paramSig = _sign(jsonString + uri);

  Response resp;
  final headers = <String, String>{
    'content-sign': paramSig,
    //'User-Agent': userAgent,
  };

  try {
    resp = await _client
        .post(url, headers: headers, body: jsonString)
        .timeout(const Duration(seconds: 10));
  } on TimeoutException catch (e) {
    _log(url, jsonString, '$e');
    res['state'] = 'timeout'; //接口超时
    return res;
  } on Exception catch (e) {
    _log(url, jsonString, '$e');

    res['state'] = 'reqerr'; //接口请求失败
    return res;
  } finally {
    //请求结束，关闭loading等待
    timer.cancel();
    toastPop?.call();
  }
  final code = resp.statusCode;
  final sig = resp.headers['content-sign'] ?? '';
  final body = resp.body;

  //状态码
  if (code != 200) {
    res['state'] = body;
    _log(url, jsonString, body);
    //if (code == 406) {
    //签名错误
    //Auth.clean();
    //}
    return res;
  }

  //提取签名
  if (sig.isEmpty) {
    //没有签名
    res['state'] = 'nosign'; //没有签名
    _log(url, jsonString, res['state'] as String);
    return res;
  }

  //校验
  if (!_verifySign(body + uri, sig)) {
    res['state'] = 'signerr'; //签名错误
    _log(url, jsonString, res['state'] as String);
    return res;
  }

  //序列化
  final jsonMap = jsonDecode(body) as Map<String, dynamic>;

  //手动序列化外围字段
  final dynamic state = jsonMap['state'];
  if (state == null) {
    res['state'] = 'nostate'; //未发现state字段,返回值不满足序列化条件
    _log(url, jsonString, res['state'] as String);
    return res;
  }

  //出现错误，也不序列化
  if (state != 'OK') {
    res['state'] = state;
    _log(url, jsonString, res['state'] as String);
    return res;
  }

  //检查时间
  final dynamic timestamp = jsonMap['timestamp'];
  if (timestamp == null) {
    res['state'] = 'nots'; //未发现timestamp字段,返回值不满足序列化条件
    _log(url, jsonString, res['state'] as String);
    return res;
  }
  final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  final st = timestamp as int;

  if (st != 0 && !(st - 60 <= now && now <= st + 60)) {
    res['state'] = 'nullify'; //请求已经失效失效
    _log(url, jsonString, res['state'] as String);
    return res;
  }

  _log(url, jsonString, body);

  //满足需求
  res['state'] = state;

  //数据
  final dynamic data = jsonMap['data'];
  if (data == null) {
    //不序列化
    return res;
  }
  res['data'] = data;
  return res;
}

void close() {
  _client.close();
}

void _log(Uri url, String req, String rawRes) {
  if (!const bool.fromEnvironment('dart.vm.product') &&
      !const bool.fromEnvironment('dart.vm.profile')) {
    final res = rawRes.trim();

    var title = 'OK';
    var color = 32;
    if (!res.startsWith('{"state":"OK"')) {
      title = 'ERROR';
      color = 31;
    }
    logger(
      '\x1B[${color}m'
      '┏━━━━━━━━━━━━━━━━━━━━━━━━━ $title ━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n'
      '┃ 地址: $url\n'
      '┃ 参数: ${req.trim()}\n'
      '┃ 结果: $res\n'
      '┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'
      '\x1B[0m',
      stack: false,
    );
  }
}

String _sign(String message) {
  if (message == '') {
    return '';
  }
  return FnSecurity.md5(message + FnAuth.sk);
}

//验证
bool _verifySign(String message, String signature) {
  if (message == '' || signature == '') {
    return false;
  }
  return signature == _sign(message);
}
