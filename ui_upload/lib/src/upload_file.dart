import 'dart:async';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:ui_toast/ui_toast.dart';

Future<bool> uploadFile({
  required String signUrl,
  required Uint8List bytes,
}) async {
  //出现loading
  final pop = UiToast.showLoading();
  //发起上传
  final url = Uri.parse(signUrl);
  final response = await put(url, body: bytes);
  //关闭loading
  pop?.call();
  if (response.statusCode == 200) {
    return true;
  }
  unawaited(UiToast.show(UiToastMessage.failure()..text = response.body));
  return false;
}
