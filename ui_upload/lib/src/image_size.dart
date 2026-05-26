import 'dart:async';
import 'dart:io';

import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';

class ImageSize {
  int width = 0;
  int height = 0;
}

Future<ImageSize> imageSizeFromPath(String path) async {
  final sizeResult = ImageSizeGetter.getSizeResult(FileInput(File(path)));
  Size size = sizeResult.size;
  int width = size.width;
  int height = size.height;
  final imageSize = ImageSize();
  if (size.needRotate) {
    return imageSize
      ..width = height
      ..height = width;
  } else {
    return imageSize
      ..width = width
      ..height = height;
  }
}
