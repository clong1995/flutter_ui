import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

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
        imageProvider: NetworkImage(images[index]),
      );
    },
    itemCount: images.length,
    pageController: PageController(initialPage: widget.index),
  );
}

void photoViewerPage({
  required BuildContext context,
  required List<String> images,
  int index = 0,
  void Function(int)? onChanged,
}) => Navigator.of(context).push(
  MaterialPageRoute(
    builder: (BuildContext context) => Scaffold(
      body: PhotoView(images: images, index: index, onChanged: onChanged),
    ),
  ),
);

class PhotoViewerGrid extends StatelessWidget {
  final List<String> images;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final void Function(int)? onChanged;

  const PhotoViewerGrid({
    super.key,
    required this.images,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 5,
    this.crossAxisSpacing = 5,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    primary: false,
    padding: EdgeInsets.zero,
    itemCount: images.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
    ),
    itemBuilder: imageBuilder,
  );

  Widget imageBuilder(BuildContext context, int index) => GestureDetector(
    onTap: () => photoViewerPage(
      context: context,
      images: images,
      index: index,
      onChanged: onChanged,
    ),
    child: UiCacheImage(images[index], fit: BoxFit.cover, thumbnail: true),
  );
}
