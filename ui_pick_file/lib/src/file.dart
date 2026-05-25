import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:ui_pick_file/src/picker.dart';
import 'package:ui_pick_file/ui_pick_file.dart' show PickerFile;

class UiPickFile {
  UiPickFile._();

  //单选任意单文件
  static Future<PickerFile?> single({List<String>? allowedExtensions}) async {
    final result = await FilePicker.pickFiles(
      type: allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) {
      return null;
    }
    final xf = result.files.first.xFile;
    return pickerFile(xf);
  }

  //多选任意文件
  static Future<List<PickerFile>?> multiple({
    int? limit,
    List<String>? allowedExtensions,
  }) async {
    final result = await FilePicker.pickFiles(
      type: allowedExtensions == null ? FileType.any : FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) {
      return null;
    }
    final l = <PickerFile>[];
    for (final file in result.files) {
      l.add(await pickerFile(file.xFile));
    }
    return l;
  }

  //选择任意目录
  static Future<String?> dir() async {
    return FilePicker.getDirectoryPath();
  }

  //保存任意文件
  static Future<String?> save({
    required Uint8List bytes,
    required String fileName,
    String? dialogTitle,
  }) async {
    final outputFile = await FilePicker.saveFile(
      dialogTitle: dialogTitle,
      fileName: fileName,
      bytes: bytes,
    );
    if (outputFile != null) {
      final file = File(outputFile);
      await file.writeAsBytes(bytes);
    }
    return outputFile;
  }
}
