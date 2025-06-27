import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

import '../ui_pick_file.dart' show PickerFile;
import 'picker.dart';
import 'save_gallery.dart';

//Image.file(File(_imageFile!.path))

class PickImage {
  //拍照文件
  static Future<PickerFile?> camera({
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
  static Future<PickerFile?> single({
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
  static Future<List<PickerFile>?> multiple({
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
  static Future<String> save({
    String? fileName,
    required Uint8List bytes,
  }) async => await saveImageToGallery(fileName: fileName, bytes: bytes);

  static Future<void> saveUrl({String? fileName, required String url}) async {
    final response = await get(Uri.parse(url));
    final bytes = response.bodyBytes;
    await save(bytes: bytes, fileName: fileName);
  }
}
