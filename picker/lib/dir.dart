import 'package:file_picker/file_picker.dart';

//选择目录
Future<String?> dir() async {
  return await FilePicker.platform.getDirectoryPath();
}
