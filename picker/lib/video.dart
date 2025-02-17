import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:picker/src/picker.dart';
import 'package:picker/src/save_gallery.dart';

import 'def.dart';

//拍摄视频
Future<PickerFile?> camera() async {
  XFile? xf = await imagePicker.pickVideo(source: ImageSource.camera);
  return pickerFile(xf);
}

//单选 从相册选择视频
Future<PickerFile?> gallery() async {
  final XFile? xf = await imagePicker.pickVideo(source: ImageSource.gallery);
  return pickerFile(xf);
}

// 保存视频到相册
Future<void> save({
  String? fileName,
  required Uint8List bytes,
}) async {
  await saveVideoToGallery(
    fileName: fileName,
    bytes: bytes,
  );
}
