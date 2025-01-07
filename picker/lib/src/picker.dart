import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../def.dart';

final ImagePicker imagePicker = ImagePicker();

Future<PickerFile> pickerFile(XFile? xf) async {
  PickerFile pickerFile = PickerFile()
    ..name = xf?.name ?? ""
    ..path = xf?.path ?? "";
  if (pickerFile.path != "") {
    pickerFile.extension = extension(pickerFile.path);
    File file = File(pickerFile.path);
    int fileSize = await file.length();
    pickerFile.size = fileSize;
  }
  return pickerFile;
}