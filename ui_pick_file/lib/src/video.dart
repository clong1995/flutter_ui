import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '../ui_pick_file.dart' show PickerFile;
import 'picker.dart';
import 'save_gallery.dart';

class PickVideo {
  //TODO 压缩
  //拍摄视频
  static Future<PickerFile?> camera() async {
    XFile? xf = await imagePicker.pickVideo(source: ImageSource.camera);
    return pickerFile(xf);
  }


  //TODO 压缩
  //单选 从相册选择视频
  static Future<PickerFile?> gallery() async {
    final XFile? xf = await imagePicker.pickVideo(source: ImageSource.gallery);
    return pickerFile(xf);
  }

  // 保存视频到相册
  static Future<void> save({String? fileName, required Uint8List bytes}) async {
    await saveVideoToGallery(fileName: fileName, bytes: bytes);
  }
}
