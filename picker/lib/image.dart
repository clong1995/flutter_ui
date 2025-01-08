import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:picker/src/picker.dart';
import 'package:picker/src/save_gallery.dart';

import 'def.dart';

//Image.file(File(_imageFile!.path))

//拍照文件
Future<PickerFile?> camera() async {
  XFile? xf = await imagePicker.pickImage(source: ImageSource.camera);
  return pickerFile(xf);
}

//单选 从相册选择照片
Future<PickerFile?> single() async {
  final XFile? xf = await imagePicker.pickImage(source: ImageSource.gallery);
  return pickerFile(xf);
}

//多选 从相册选择照片
Future<List<PickerFile>> multiple() async {
  List<XFile> list = await imagePicker.pickMultiImage();
  if (list.isEmpty) {
    return [];
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
