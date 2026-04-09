import 'dart:async';
import 'dart:convert';

import 'package:fn_auth/fn_auth.dart';
import 'package:nio/src/base.dart';
import 'package:nio/src/empty.dart';
import 'package:nio/src/send.dart';
import 'package:logger/logger.dart';
import 'package:ui_toast/ui_toast.dart';

Future<T> nio<S extends BaseReq, T extends BaseRes>(
  String uri, {
  bool reTey = true,
  S? req,
  T? res,
}) async {
  //初始化返回值
  res ??= EmptyRes() as T;

  if (uri.isEmpty) {
    res.state = 'url为空';
    UiToast.show(UiToastMessage.failure()..text = res.state);
    return res;
  }

  req ??= EmptyReq() as S;

  //参数
  req
    ..t = DateTime.now().millisecondsSinceEpoch ~/ 1000
    ..a = FnAuth.ak;

  //转string
  final jsonString = jsonEncode(req);
  //发送数据
  final result = await send(uri, jsonString);
  res.state = result['state'] as String;

  switch (res.state) {
    case 'OK':
      break;
    case 'nosign':
    case 'signerr':
    case 'nostate':
    case 'nots':
    case 'nullify':
      UiToast.show(UiToastMessage.failure()..text = res.state);
    case 'limit exists':
    case 'disable replay':
      //print('=========>${res.state}<=========');
      return res;
    default:
      if (!reTey) {
        break;
      }
      final completer = Completer<bool>();
      UiToast.show(
        UiToastMessage.failure()
          ..text = '${res.state}, 是否重试?'
          ..callback = completer.complete,
      );

      final choice = await completer.future;

      if (choice) {
        return nio<S, T>(uri, req: req, res: res);
      }
  }

  final dynamic data = result['data'];
  if (data == null) {
    return res;
  }

  res.data = data as Map<String, dynamic>;
  //序列化数据
  try {
    res.fromJson();
  } catch (e) {
    final text = e.toString();
    UiToast.show(UiToastMessage.failure()..text = text);

    logger(
      '\x1B[31m'
      '┏━━━━━━━━━━━━━━━━━━━━━━━━━ ERROR ━━━━━━━━━━━━━━━━━━━━━━━━━━━┓\n'
      '┃ 地址: $uri\n'
      '┃ 序列化错误: $text\n'
      '┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛'
      '\x1B[0m',
      stack: false,
    );
    rethrow;
  }
  return res;
}
