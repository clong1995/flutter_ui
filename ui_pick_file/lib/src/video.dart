import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:ui_pick_file/src/picker.dart';
import 'package:ui_pick_file/src/save_gallery.dart';
import 'package:ui_pick_file/ui_pick_file.dart' show PickerFile;

class PickVideo {
  //TODO(user): 压缩
  //拍摄视频
  static Future<PickerFile?> camera() async {
    final xf = await imagePicker.pickVideo(source: ImageSource.camera);
    return pickerFile(xf);
  }


  //TODO(user): 压缩
  //单选 从相册选择视频
  static Future<PickerFile?> gallery() async {
    final xf = await imagePicker.pickVideo(source: ImageSource.gallery);
    return pickerFile(xf);
  }

  // 保存视频到相册
  static Future<void> save({required Uint8List bytes, String? fileName}) async {
    await saveVideoToGallery(fileName: fileName, bytes: bytes);
  }
}
