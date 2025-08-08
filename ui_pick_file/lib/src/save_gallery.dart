//保存图片到相册
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

Future<String> saveImageToGallery({
  String? fileName,
  required Uint8List bytes,
}) async {
  if (fileName == null || fileName.isEmpty) {
    fileName = "${DateTime.now().millisecondsSinceEpoch}";
  }
  final result = await ImageGallerySaverPlus.saveImage(
    bytes,
    quality: 100,
    name: fileName,
  );
  if (result['isSuccess'] == true) {
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

  final result = await ImageGallerySaverPlus.saveFile(
    file.path,
    name: fileName,
  );
  if (result['isSuccess'] == true) {
    return "";
  }
  return result.errorMessage ?? "saver gallery error";
}
