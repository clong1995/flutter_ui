import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

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
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Stack(
      children: [
        PhotoViewGallery.builder(
          onPageChanged: (index) {
            currIndex = index;
          },
          builder: (BuildContext context, int index) {
            if (currIndex != index) {
              widget.onChanged?.call(index);
            }
            currIndex = index;
            return PhotoViewGalleryPageOptions(
              imageProvider: UiCacheImageProvider(images[index]),
            );
          },
          itemCount: images.length,
          pageController: PageController(initialPage: widget.index),
        ),
        Positioned(
          top: padding.top + 15,
          left: padding.left + 15,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Row(
              children: [
                IconButton(
                  padding: EdgeInsets.all(5),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                IconButton(
                  padding: EdgeInsets.all(5),
                  onPressed: () => saveImage(images[currIndex]),
                  icon: const Icon(Icons.save_alt),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> saveImage(String imageUrl) async {
    final response = await get(Uri.parse(imageUrl));
    final bytes = response.bodyBytes;
    final result = await ImageGallerySaverPlus.saveImage(bytes, quality: 100);

    if (result['isSuccess'] == true) {
      snackBar("保存成功");
    } else {
      snackBar("保存失败");
    }
  }

  void snackBar(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
  }
}
