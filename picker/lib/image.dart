import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:picker/src/picker.dart';
import 'package:picker/src/save_gallery.dart';

import 'def.dart';

//Image.file(File(_imageFile!.path))

//拍照文件
Future<PickerFile?> camera({
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
}) async {
  XFile? xf = await imagePicker.pickImage(
    source: ImageSource.camera,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
  );
  return pickerFile(xf);
}

//单选 从相册选择照片
Future<PickerFile?> single({
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
}) async {
  final XFile? xf = await imagePicker.pickImage(
    source: ImageSource.gallery,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
  );
  return pickerFile(xf);
}

//多选 从相册选择照片
Future<List<PickerFile>?> multiple({
  double? maxWidth,
  double? maxHeight,
  int? imageQuality,
  int? limit,
}) async {
  List<XFile> list = await imagePicker.pickMultiImage(
    maxWidth: maxWidth,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    limit: limit,
  );
  if (list.isEmpty) {
    return null;
  }
  List<PickerFile> l = [];
  for (XFile xf in list) {
    PickerFile pf = await pickerFile(xf);
    l.add(pf);
  }
  return l;
}

// 保存图片到相册
Future<void> save({
  String? fileName,
  required Uint8List bytes,
}) async {
  await saveToGallery(
    fileName: fileName,
    bytes: bytes,
  );
}
