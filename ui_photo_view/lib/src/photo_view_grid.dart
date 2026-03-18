// PhotoViewGrid 集成了 uiPhotoViewPage
import 'package:flutter/material.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

import 'package:ui_photo_view/src/push_photo_view_page.dart';

class UiPhotoViewGrid extends StatelessWidget {

  const UiPhotoViewGrid({
    required this.images, super.key,
    this.thumbnail = true,
    this.crossAxisCount = 3,
    this.mainAxisSpacing = 5,
    this.crossAxisSpacing = 5,
    this.onChanged,
  });
  final bool thumbnail;
  final List<String> images;
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final void Function(int)? onChanged;

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
    itemBuilder: (context, index) {
      var image = images[index];
      if(thumbnail){
        final uri = Uri.parse(image).replace(
          queryParameters: {
            ...Uri.parse(image).queryParameters,
            'x-oss-process': 'style/thumbnail'
          }
        );
        image = uri.toString();
      }
      return GestureDetector(
        onTap: () => onImageTap(index),
        child: UiCacheImage(image, fit: BoxFit.contain),
      );
    },
  );

  void onImageTap(int index) => pushPhotoViewPage(
    images: images,
    index: index,
    onChanged: onChanged,
  );
}
