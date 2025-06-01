import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


import '../ui_pick_file.dart' show PickerFile;

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
      String ext = extension(pickerFile.name);
      if (pickerFile.name.length > ext.length) {
        pickerFile.name =
            pickerFile.name.substring(0, pickerFile.name.length - ext.length);
      }
      pickerFile.extension = ext.replaceAll(RegExp(r'^\.+'), '');
    }

    final fileSize = (await xf?.length()) ?? 0;
    pickerFile.size = fileSize;
    pickerFile.bytes = xf?.readAsBytes ?? () async => Uint8List(0);
  }
  return pickerFile;
}
