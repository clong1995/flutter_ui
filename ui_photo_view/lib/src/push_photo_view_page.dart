//从任意位置跳到连续的PhotoViewPage，比如聊天里的图，缩略图的某一个图
import 'package:flutter/material.dart';
import 'package:nav/nav.dart';

import 'photo_view.dart';

Future<void> pushPhotoViewPage({
  required BuildContext context,
  required List<String> images,
  int index = 0,
  void Function(int)? onChanged,
}) => Nav.push(
  context,
  () => Scaffold(
    body: PhotoView(images: images, index: index, onChanged: onChanged),
  ),
);
