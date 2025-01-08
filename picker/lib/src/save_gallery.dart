//保存图片到相册
import 'dart:io';
import 'dart:typed_data';

import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';

Future<void> saveToGallery({
  String? fileName,
  required Uint8List bytes,
}) async {
  Directory appDocDir = await getTemporaryDirectory();
  if(fileName == null || fileName.isEmpty){
    fileName = "${DateTime.now().millisecondsSinceEpoch}";
  }
  String savePath = appDocDir.path + fileName;
  File file = File(savePath);
  await file.writeAsBytes(bytes);

  await ImageGallerySaverPlus.saveFile(
    savePath,
    name: fileName,
  );
}