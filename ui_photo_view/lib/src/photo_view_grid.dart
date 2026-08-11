// PhotoViewGrid 集成了 uiPhotoViewPage
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_cache_image/ui_cache_image.dart';
import 'package:ui_photo_view/src/push_photo_view_page.dart';

class UiPhotoViewGrid extends StatelessWidget {
  const UiPhotoViewGrid({
    required this.images,
    super.key,
    this.thumbnail = true,
    this.crossAxisCount = 3,
    this.fit = BoxFit.contain,
    this.childAspectRatio = 1,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.borderRadius = BorderRadius.zero,
    this.onChanged,
  });

  final bool thumbnail;
  final List<String> images;
  final int crossAxisCount;
  final double childAspectRatio;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
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
      childAspectRatio: childAspectRatio,
      mainAxisSpacing: mainAxisSpacing ?? 5.r,
      crossAxisSpacing: crossAxisSpacing ?? 5.r,
    ),
    itemBuilder: (context, index) => GestureDetector(
        onTap: () => onImageTap(index),
        child: ClipRRect(
          borderRadius: borderRadius,
          child: UiCacheImage(images[index], fit: fit,thumbnail: thumbnail,),
        ),
      ),
  );

  void onImageTap(int index) => pushPhotoViewPage(
    images: images,
    index: index,
    onChanged: onChanged,
  );
}
