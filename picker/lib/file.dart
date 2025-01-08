import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

import 'def.dart';

//单选任意单文件
Future<PickerFile?> single([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: allowedExtensions,
  );
  if (result == null) {
    return null;
  }
  PlatformFile platformFile = result.files.first;
  PickerFile pickerFile = PickerFile()
    ..name = platformFile.name
    ..size = platformFile.size
    ..extension = platformFile.extension ?? ""
    ..path = platformFile.path ?? "";
  return pickerFile;
}

//多选任意文件
Future<List<PickerFile>> multiple([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    allowedExtensions: allowedExtensions,
  );
  if (result == null) {
    return [];
  }
  return result.files
      .map<PickerFile>((PlatformFile file) => PickerFile()
        ..name = file.name
        ..size = file.size
        ..extension = file.extension ?? ""
        ..path = file.path ?? "")
      .toList(growable: false);
}

//选择任意目录
Future<String?> dir() async {
  return await FilePicker.platform.getDirectoryPath();
}

//保存任意文件
Future<String?> save({
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
