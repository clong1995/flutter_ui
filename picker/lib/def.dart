import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

abstract class PickerFile {
  String get name;
  String get extension;
  String get path;
  int get size;

  Future<Uint8List> readAsBytes();
}

// 实现
class PickerXFileImpl extends PickerFile {
  final XFile? xf;
  @override
  final int size;
  PickerXFileImpl(this.xf, this.size);
  @override
  String get extension {
    String name = xf?.name ?? "";
    // .xxx
    if (name.isEmpty || name.startsWith(".")) {
      return name;
    } else {
      String ext = p.extension(xf?.path ?? "");

      return ext.replaceAll(RegExp(r'^\.+'), '');
    }
  }

  @override
  String get name {
    String _name = xf?.name ?? "";
    String _path = xf?.path ?? "";
    if (_path != "") {
      if (_name.isEmpty || _name.startsWith(".")) {
        _name = "";
      } else {
        String ext = p.extension(_path);
        if (_name.length > ext.length) {
          _name = _name.substring(0, _name.length - ext.length);
        }
      }
    }
    return _name;
  }

  @override
  String get path => xf?.path ?? "";

  @override
  Future<Uint8List> readAsBytes() async {
    return await xf?.readAsBytes() ?? Uint8List(0);
  }
}
