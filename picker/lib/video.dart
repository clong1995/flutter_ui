import 'package:image_picker/image_picker.dart';
import 'package:picker/src/picker.dart';

import 'def.dart';

Future<PickerFile?> camera() async {
  XFile? xf = await imagePicker.pickVideo(source: ImageSource.camera);
  return pickerFile(xf);
}

Future<PickerFile?> video() async {
  final XFile? xf = await imagePicker.pickVideo(source: ImageSource.gallery);
  return pickerFile(xf);
}

save() {}
