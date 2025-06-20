// PhotoViewGrid 集成了 uiPhotoViewPage
import 'package:flutter/material.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

import 'push_photo_view_page.dart';

class PhotoViewGrid extends StatelessWidget {
  final List<String> images;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final void Function(int)? onChanged;

  const PhotoViewGrid({
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
    itemBuilder: (context, index) => GestureDetector(
      onTap: () => onImageTap(context, index),
      child: UiCacheImage(images[index], fit: BoxFit.contain),
    ),
  );

  void onImageTap(BuildContext context, int index) => pushPhotoViewPage(
    context: context,
    images: images,
    index: index,
    onChanged: onChanged,
  );
}
