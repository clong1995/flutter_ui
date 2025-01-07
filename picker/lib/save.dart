import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

//选择目录
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
  if(outputFile != null){
    File file = File(outputFile);
    await file.writeAsBytes(bytes);
  }
  return outputFile;
}
