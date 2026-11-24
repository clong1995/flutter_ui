//保存图片到相册
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:gal/gal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ui_toast/ui_toast.dart';

Future<void> saveImageToGallery({
  required Uint8List bytes,
  String? fileName,
}) async {
  late String name;
  if (fileName == null || fileName.isEmpty) {
    name = '${DateTime.now().millisecondsSinceEpoch}';
  } else {
    name = fileName;
  }

  try {
    await Gal.putImageBytes(bytes,name: name);
    // 保存成功
    unawaited(UiToast.show(.success()..text = '保存成功'));
  } on GalException catch (e) {
    // 下载或保存失败
    unawaited(UiToast.show(.failure()..text = e.type.message));
  }
}

Future<void> saveVideoToGallery({
  required Uint8List bytes,
  String? fileName,
}) async {
  final appDocDir = await getTemporaryDirectory();
  late String name;
  if (fileName == null || fileName.isEmpty) {
    name = '${DateTime.now().millisecondsSinceEpoch}';
  } else {
    name = fileName;
  }
  final savePath = appDocDir.path + name;
  final file = File(savePath);
  await file.writeAsBytes(bytes);
  try {
    await Gal.putVideo(file.path);
    // 保存成功
    unawaited(UiToast.show(.success()..text = '保存成功'));
  } on GalException catch (e) {
    // 下载或保存失败
    unawaited(UiToast.show(.failure()..text = e.type.message));
  }
}
