import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_pick_file/src/picker.dart';
import 'package:ui_pick_file/src/save_gallery.dart';
import 'package:ui_pick_file/ui_pick_file.dart' show PickerFile;

//Image.file(File(_imageFile!.path))

class UiPickImage {
  UiPickImage._();

  //拍照文件
  static Future<PickerFile?> camera({
    double? maxWidth,
    double? maxHeight,
    int? imageQuality,
  }) async {
    final xf = await imagePicker.pickImage(
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
    final xf = await imagePicker.pickImage(
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
    final list = await imagePicker.pickMultiImage(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      imageQuality: imageQuality,
      limit: limit,
    );
    if (list.isEmpty) {
      return null;
    }
    final l = <PickerFile>[];
    for (final xf in list) {
      final pf = await pickerFile(xf);
      l.add(pf);
    }
    return l;
  }

  // 保存图片到相册
  static Future<String> save({
    required Uint8List bytes,
    String? fileName,
  }) async => saveImageToGallery(fileName: fileName, bytes: bytes);

  static Future<void> saveUrl({required String url, String? fileName}) async {
    final response = await get(Uri.parse(url));
    final bytes = response.bodyBytes;
    await save(bytes: bytes, fileName: fileName);
  }
}
