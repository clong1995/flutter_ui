import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:ui_toast/ui_toast.dart';

Future<bool> uploadFile({
  required String signUrl,
  required Uint8List bytes,
}) async {
  //出现loading
  UiToast.show(UiToastMessage.loading());
  //发起上传
  final url = Uri.parse(signUrl);
  final response = await put(url, body: bytes);
  //关闭loading
  UiToast.dismiss();
  if (response.statusCode == 200) {
    return true;
  }
  UiToast.show(UiToastMessage.failure()..text = response.body);
  return false;
}
