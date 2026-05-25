import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:fn_device/fn_device.dart';
import 'package:http/http.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_cache_image/ui_cache_image.dart';
import 'package:ui_theme/ui_theme.dart';
import 'package:ui_toast/ui_toast.dart';

//PhotoView 的实现
class UiPhotoView extends StatefulWidget {
  const UiPhotoView({
    required this.images,
    super.key,
    this.index = 0,
    this.onChanged,
  });

  final List<String> images;
  final int index;
  final void Function(int)? onChanged;

  @override
  State<UiPhotoView> createState() => _UiPhotoViewState();
}

class _UiPhotoViewState extends State<UiPhotoView> {
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
    return Stack(
      children: [
        PhotoViewGallery.builder(
          onPageChanged: (index) {
            currIndex = index;
          },
          builder: (context, index) {
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
          top: FnDevice.statusBarHeight,
          left: 15.r,
          child: Container(
            height: 35.r,
            padding: EdgeInsets.symmetric(horizontal: 5.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.r),
              color: UiTheme.white,
            ),
            child: Row(
              spacing: 5.r,
              children: [
                UiIconButton(
                  background: false,
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.pop(context),
                ),
                UiIconButton(
                  background: false,
                  icon: Icons.save_alt,
                  onTap: () => saveImage(images[currIndex]),
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
      //snackBar('保存成功');
      UiToast.show(UiToastMessage.success()..text = '保存成功');
    } else {
      // snackBar('保存失败');
      UiToast.show(UiToastMessage.failure()..text = '保存失败');
    }
  }

  /*void snackBar(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(str)));
  }*/
}
