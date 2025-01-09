import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

import 'def.dart';
import 'src/picker.dart';

//单选任意单文件
Future<PickerFile?> single([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowedExtensions: allowedExtensions,
  );
  if (result == null) {
    return null;
  }
  XFile xf = result.files.first.xFile;
  return pickerFile(xf);
}

//多选任意文件
Future<List<PickerFile>?> multiple([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
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
