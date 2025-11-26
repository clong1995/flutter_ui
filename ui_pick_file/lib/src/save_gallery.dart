//保存图片到相册
import 'dart:io';
import 'dart:typed_data';

import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<String> saveImageToGallery({
  required Uint8List bytes, String? fileName,
}) async {
  if (fileName == null || fileName.isEmpty) {
    fileName = '${DateTime
        .now()
        .millisecondsSinceEpoch}';
  }
  final result = await ImageGallerySaverPlus.saveImage(
    bytes,
    quality: 100,
    name: fileName,
  );
  if (result['isSuccess'] == true) {
    return '';
  }
  if (result.errorMessage == null) {
    return 'saver gallery error';
  }
  return result.errorMessage.toString();
}

Future<String> saveVideoToGallery({
  required Uint8List bytes, String? fileName,
}) async {
  final appDocDir = await getTemporaryDirectory();
  if (fileName == null || fileName.isEmpty) {
    fileName = '${DateTime
        .now()
        .millisecondsSinceEpoch}';
  }
  final savePath = appDocDir.path + fileName;
  final file = File(savePath);
  await file.writeAsBytes(bytes);

  final result = await ImageGallerySaverPlus.saveFile(
    file.path,
    name: fileName,
  );
  if (result['isSuccess'] == true) {
    return '';
  }
  if (result.errorMessage == null) {
    return 'saver gallery error';
  }
  return result.errorMessage.toString();
}
