import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../ui_pick_file.dart' show PickerFile;
import 'picker.dart';

class PickFile {
  //单选任意单文件
  static Future<PickerFile?> single({List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) {
      return null;
    }
    XFile xf = result.files.first.xFile;
    return pickerFile(xf);
  }

  //多选任意文件
  static Future<List<PickerFile>?> multiple({
    int? limit, //TODO
    List<String>? allowedExtensions,
  }) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) {
      return null;
    }
    List<PickerFile> l = [];
    for (PlatformFile file in result.files) {
      l.add(await pickerFile(file.xFile));
    }
    return l;
  }

  //选择任意目录
  static Future<String?> dir() async {
    return await FilePicker.platform.getDirectoryPath();
  }

  //保存任意文件
  static Future<String?> save({
    String? dialogTitle,
    String? fileName,
    required Uint8List bytes,
  }) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: dialogTitle,
      fileName: fileName,
      bytes: bytes,
    );
    if (outputFile != null) {
      File file = File(outputFile);
      await file.writeAsBytes(bytes);
    }
    return outputFile;
  }
}
