import 'package:flutter/foundation.dart';

class PickerFile {
  String name = '';
  String extension = '';
  String path = '';
  int size = 0;
  Future<Uint8List> Function() bytes = () async => Uint8List(0);
}
