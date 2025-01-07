import 'package:image_picker/image_picker.dart';
import 'package:picker/src/picker.dart';

import 'def.dart';

Future<PickerFile?> camera() async {
  XFile? xf = await imagePicker.pickImage(source: ImageSource.camera);
  return pickerFile(xf);
}

Future<PickerFile?> photo() async {
  final XFile? xf = await imagePicker.pickImage(source: ImageSource.gallery);
  return pickerFile(xf);
}

Future<List<PickerFile>> multiple() async {
  List<XFile> list = await imagePicker.pickMultiImage();
  if (list.isEmpty) {
    return [];
  }
  List<PickerFile> l = [];
  for (XFile xf in list) {
    PickerFile pf = await pickerFile(xf);
    l.add(pf);
  }
  return l;
}

save() {}
