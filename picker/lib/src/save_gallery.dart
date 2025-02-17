//保存图片到相册
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:saver_gallery/saver_gallery.dart';

Future<String> saveImageToGallery({
  String? fileName,
  required Uint8List bytes,
}) async {
  if (fileName == null || fileName.isEmpty) {
    fileName = "${DateTime.now().millisecondsSinceEpoch}";
  }
  final result = await SaverGallery.saveImage(bytes,
      fileName: fileName, skipIfExists: true);
  // result.isSuccess
  if (result.isSuccess) {
    return "";
  }
  return result.errorMessage ?? "saver gallery error";
}

Future<String> saveVideoToGallery({
  String? fileName,
  required Uint8List bytes,
}) async {
  Directory appDocDir = await getTemporaryDirectory();
  if (fileName == null || fileName.isEmpty) {
    fileName = "${DateTime.now().millisecondsSinceEpoch}";
  }
  String savePath = appDocDir.path + fileName;
  File file = File(savePath);
  await file.writeAsBytes(bytes);

  final result = await SaverGallery.saveFile(
    filePath: file.path,
    fileName: fileName,
    skipIfExists: true,
  );
  if (result.isSuccess) {
    return "";
  }
  return result.errorMessage ?? "saver gallery error";
}
