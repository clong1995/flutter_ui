import 'package:file_picker/file_picker.dart';

import 'def.dart';

//单文件
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
    ..path = platformFile.path ?? ""
    ..hash = platformFile.hashCode;
  return pickerFile;
}

//多选
Future<List<PickerFile>> multiple([List<String>? allowedExtensions]) async {
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    allowedExtensions: allowedExtensions,
  );
  if (result == null) {
    return [];
  }
  return result.files.map<PickerFile>((PlatformFile file) => PickerFile()
    ..name = file.name
    ..size = file.size
    ..extension = file.extension ?? ""
    ..path = file.path ?? ""
    ..hash = file.hashCode).toList(growable: false);
}
