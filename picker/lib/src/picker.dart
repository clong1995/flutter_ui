import 'package:image_picker/image_picker.dart';

import '../def.dart';

final ImagePicker imagePicker = ImagePicker();

Future<PickerFile> pickerFile(XFile? xf) async {
  final fileSize = (await xf?.length()) ?? 0;
  return PickerXFileImpl(xf, fileSize);
}
