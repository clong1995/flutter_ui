import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../def.dart';

final ImagePicker imagePicker = ImagePicker();

Future<PickerFile> pickerFile(XFile? xf) async {
  PickerFile pickerFile = PickerFile()..path = xf?.path ?? "";
  if (pickerFile.path != "") {
    if (xf != null && xf.name.isNotEmpty) {
      pickerFile.name = xf.name;
    }
    if (pickerFile.name.isEmpty || pickerFile.name.startsWith(".")) {
      pickerFile.extension = pickerFile.name;
      pickerFile.name = "";
    } else {
      String ext = extension(pickerFile.path);
      if (pickerFile.name.length > ext.length) {
        pickerFile.name =
            pickerFile.name.substring(0, pickerFile.name.length - ext.length);
      }
      pickerFile.extension = ext.replaceAll(RegExp(r'^\.+'), '');
    }
    File file = File(pickerFile.path);
    int fileSize = await file.length();
    pickerFile.size = fileSize;
  }
  return pickerFile;
}
