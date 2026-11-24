import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_pick_file/src/image_size.dart';
import 'package:ui_pick_file/src/picker.dart';
import 'package:ui_pick_file/src/save_gallery.dart';
import 'package:ui_pick_file/ui_pick_file.dart' show PickerFile;

//Image.file(File(_imageFile!.path))

class UiPickImage {
  new _();

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

    final pf = await pickerFile(xf);

    final size = await imageSizeFromPath(pf.path);
    pf
      ..width = size.width
      ..height = size.height;
    return pf;
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
    final pf = await pickerFile(xf);

    final size = await imageSizeFromPath(pf.path);
    pf
      ..width = size.width
      ..height = size.height;
    return pf;
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
      final size = await imageSizeFromPath(pf.path);
      pf
        ..width = size.width
        ..height = size.height;
      l.add(pf);
    }
    return l;
  }

  // 保存图片到相册
  static Future<void> save({
    required Uint8List bytes,
    String? fileName,
  }) async => await saveImageToGallery(fileName: fileName, bytes: bytes);

  static Future<void> saveUrl({required String url, String? fileName}) async {
    final bytes = await readBytes(Uri.parse(url));
    await save(bytes: bytes, fileName: fileName);
  }
}
