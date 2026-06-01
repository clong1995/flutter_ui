import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:fn_device/fn_device.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:rpx/ext.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_cache_image/ui_cache_image.dart';
import 'package:ui_photo_view/ui_photo_view.dart';
import 'package:ui_theme/ui_theme.dart';
import 'package:ui_toast/ui_toast.dart';
import 'package:ui_upload/src/sign_url.dart';
import 'package:ui_upload/src/upload.dart';

class UiUploadImageWidget extends StatefulWidget {
  const UiUploadImageWidget({
    required this.signUrl,
    this.crossAxisCount,
    required this.onChanged,
    super.key,
    this.list,
    this.spacing,
    this.maxWidth,
    this.maxHeight,
    this.imageQuality,
    this.limit,
  });

  final int? crossAxisCount;
  final void Function(List<String> images) onChanged;
  final List<String>? list;
  final double? spacing;
  final double? maxWidth;
  final double? maxHeight;
  final int? imageQuality;
  final int? limit;

  //final String path;

  final Future<List<SignUrl>> Function(List<String> fileName) signUrl;

  @override
  State<UiUploadImageWidget> createState() => _UiUploadImageWidgetState();
}

class _UiUploadImageWidgetState extends State<UiUploadImageWidget> {
  List<String> imageList = [];

  double spacing = 0;

  @override
  void initState() {
    super.initState();
    spacing = widget.spacing ?? 5.r;
  }

  @override
  Widget build(BuildContext context) {
    if (imageList.isEmpty) {
      imageList = widget.list ?? [];
    }
    return widget.limit == null ? single() : multiple();
  }

  Widget multiple() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    primary: false,
    padding: EdgeInsets.zero,
    itemCount: imageList.length + 1,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: widget.crossAxisCount ?? 3,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
    ),
    itemBuilder: (BuildContext context, int index) {
      return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: UiTheme.grey50,
          border: Border.all(color: UiTheme.grey100),
          borderRadius: BorderRadius.circular(5.r)
        ),
        child: index == imageList.length
            ? Center(
                child: UiIconButton(
                  onTap: onMultiTap,
                  width: 45.r,
                  height: 45.r,
                  size: 25.r,
                  icon: Icons.add_photo_alternate_outlined,
                ),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () => imageWidget(index),
                    child: UiCacheImage(imageList[index], fit: BoxFit.contain),
                  ),
                  removeWidget(index),
                ],
              ),
      );
    },
  );

  Widget single() => AspectRatio(
    aspectRatio: 1,
    child: DecoratedBox(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.r)),
      child: Stack(
        children: [
          if (imageList.isNotEmpty)
            GestureDetector(
              onTap: () async {
                await imageWidget(0);
              },
              child: UiCacheImage(imageList[0], fit: BoxFit.contain),
            ),
          if (imageList.isNotEmpty) removeWidget(0),
          if (imageList.isEmpty)
            Center(
              child: UiIconButton(
                onTap: onSingleTap,
                width: 45.r,
                height: 45.r,
                size: 25.r,
                icon: Icons.add_photo_alternate_outlined,
              ),
            ),
        ],
      ),
    ),
  );

  Widget removeWidget(int index) => Positioned(
    top: 0,
    right: 0,
    child: UiIconButton(
      onTap: () {
        imageList.removeAt(index);
        widget.onChanged(imageList);
        setState(() {});
      },
      background: false,
      icon: Icons.cancel,
      color: UiTheme.red,
    ),
  );

  Future<void> onMultiTap() async {
    if (widget.limit != null) {
      if (imageList.length >= widget.limit!) {
        UiToast.show(UiToastMessage.info()..text = '最多上传 ${widget.limit} 张');
        return;
      }
    }

    await Upload.gallery(
      type: 'photo',
      //path: widget.path,
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      imageQuality: widget.imageQuality,
      limit: widget.limit,
      signUrl: widget.signUrl,
      uploadStep: (download) {
        imageList.add(download);
        if (widget.limit != null) {
          if (imageList.length > widget.limit!) {
            imageList = imageList.sublist(0, widget.limit);
          }
        }
        widget.onChanged(imageList);
        setState(() {});
      },
    );
  }

  Future<void> onSingleTap() async {
    await Upload.gallery(
      type: 'photo',
      // path: widget.path,
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      imageQuality: widget.imageQuality,
      signUrl: widget.signUrl,
      uploadStep: (download) {
        imageList = [download];
        widget.onChanged(imageList);
        setState(() {});
      },
    );
  }

  Future<void> imageWidget(int index) async {
    await FnNav.push(
      () => _PhotoViewer(
        index: index,
        images: [...imageList],
        onDelete: (int index) {
          imageList.removeAt(index);
          widget.onChanged(imageList);
          setState(() {});
        },
      ),
    );
  }
}

class _PhotoViewer extends StatefulWidget {
  const _PhotoViewer({
    required this.index,
    required this.images,
    this.onDelete,
  });

  final int index;
  final List<String> images;
  final void Function(int index)? onDelete;

  @override
  State<_PhotoViewer> createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<_PhotoViewer> {
  //late int initialIndex;
  late int currIndex;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    images = widget.images;
    currIndex = widget.index;
    //initialIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      UiPhotoView(
        // index: initialIndex,
        index: currIndex,
        images: images,
        onChanged: (int index) {
          currIndex = index;
        },
      ),
      if (widget.onDelete != null)
        Positioned(
          left: 15.r,
          right: 15.r,
          bottom: FnDevice.bottomSafeHeight,
          child: Center(
            child: UiButton(
              height: 35.r,
              color: UiTheme.red,
              onTap: remove,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Icon(Icons.delete_forever_outlined), Text(' 删 除')],
              ),
            ),
          ),
        ),
    ],
  );

  Future<void> remove() async {
    final select = await UiToast.show(
      UiToastMessage.info()
        ..text = '确定删除这张图片?'
        ..autoPopSeconds = 0
        ..select = true,
    );
    if (select == true) {
      final isLast = currIndex == images.length - 1;
      //
      images.removeAt(currIndex);
      //删除
      widget.onDelete?.call(currIndex);
      if (images.isNotEmpty) {
        if(isLast){ //删掉的是最后一张
          currIndex = images.length - 1;
        }
        setState(() {});
      } else {
        //没有了
        //if (!mounted) return;
        FnNav.pop();
      }
    }
  }
}
