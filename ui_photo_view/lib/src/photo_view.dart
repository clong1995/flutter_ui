import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

//PhotoView 的实现
class PhotoView extends StatefulWidget {
  final List<String> images;
  final int index;
  final void Function(int)? onChanged;

  const PhotoView({
    super.key,
    required this.images,
    this.index = 0,
    this.onChanged,
  });

  @override
  State<PhotoView> createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late int currIndex;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    images = widget.images;
    currIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) => PhotoViewGallery.builder(
    builder: (BuildContext context, int index) {
      if (currIndex != index) {
        widget.onChanged?.call(index);
      }
      currIndex = index;
      return PhotoViewGalleryPageOptions(
        //TODO 这里要变成缓存，但是缓存没有imageProvider
        imageProvider: NetworkImage(images[index]),
      );
    },
    itemCount: images.length,
    pageController: PageController(initialPage: widget.index),
  );
}
