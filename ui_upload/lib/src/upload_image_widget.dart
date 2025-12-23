import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_cache_image/ui_cache_image.dart';
import 'package:ui_photo_view/ui_photo_view.dart';
import 'package:ui_toast/ui_toast.dart';
import 'package:ui_upload/src/sign_url.dart';
import 'package:ui_upload/src/upload.dart';

class UploadImageWidget extends StatefulWidget {
  const UploadImageWidget({
    required this.signUrl,
    required this.crossAxisCount,
    required this.onChanged,
    // required this.path,
    super.key,
    this.list,
    this.spacing,
    this.iconSize,
    this.maxWidth,
    this.maxHeight,
    this.imageQuality,
    this.limit,
  });

  final int crossAxisCount;
  final void Function(List<String> images) onChanged;
  final List<String>? list;
  final double? spacing;
  final double? iconSize;
  final double? maxWidth;
  final double? maxHeight;
  final int? imageQuality;
  final int? limit;

  //final String path;

  final Future<List<SignUrl>?> Function(List<String> fileName) signUrl;

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  List<String> imageList = [];

  double spacing = 0;

  @override
  void initState() {
    super.initState();
    spacing = widget.spacing ?? 5;
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
      crossAxisCount: widget.crossAxisCount,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
    ),
    itemBuilder: (BuildContext context, int index) {
      return index == imageList.length
          ? InkWell(
              onTap: onMultiTap,
              child: Card(
                clipBehavior: Clip.antiAlias,
                color: Colors.grey.shade50,
                margin: EdgeInsets.zero,
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  size: widget.iconSize,
                  color: Colors.grey,
                ),
              ),
            )
          : Card(
              clipBehavior: Clip.antiAlias,
              color: Colors.grey.shade50,
              margin: EdgeInsets.zero,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await imageWidget(index);
                    },
                    child: UiCacheImage(
                      imageList[index],
                      fit: BoxFit.contain,
                    ),
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
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
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
              child: GestureDetector(
                onTap: onSingleTap,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(
                    Icons.add_photo_alternate_outlined,
                    size: widget.iconSize,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );

  Widget removeWidget(int index) => Positioned(
    top: spacing * 2,
    right: spacing * 2,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          imageList.removeAt(index);
          widget.onChanged(imageList);
          setState(() {});
        },
        child: const Icon(Icons.cancel, color: Colors.red),
      ),
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
      uploadStep: (String download) {
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
    final images = await Upload.gallery(
      type: 'photo',
      // path: widget.path,
      maxWidth: widget.maxWidth,
      maxHeight: widget.maxHeight,
      imageQuality: widget.imageQuality,
      signUrl: widget.signUrl,
    );
    if (images == null || images.isEmpty) return;
    widget.onChanged(imageList);
    setState(() {});
  }

  Future<void> imageWidget(int index) async {
    await Nav.push(
      context,
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
  late int initialIndex;
  late int currIndex;
  late List<String> images;

  @override
  void initState() {
    super.initState();
    images = widget.images;
    currIndex = widget.index;
    initialIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      UiPhotoView(
        index: initialIndex,
        images: images,
        onChanged: (int index) {
          currIndex = index;
        },
      ),
      const Positioned(left: 10, top: 10, child: BackButton()),
      if (widget.onDelete != null)
        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: Center(
            child: FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: remove,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete_forever_outlined),
                  Text('删除', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
    ],
  );

  Future<void> remove() async {
    final flag = await alertConfirm(
      context: context,
      content: '确定删除这张图片?',
    );

    if (flag ?? false) {
      //
      images.removeAt(currIndex);
      //删除
      widget.onDelete?.call(currIndex);
      if (images.isNotEmpty) {
        //还有照片
        if (images.length > currIndex) {
          //后面还有，则下一张
          initialIndex = currIndex;
        } else if (images.length == currIndex) {
          //后面没有了，则前一张
          initialIndex = currIndex - 1;
        }
        setState(() {});
      } else {
        //没有了
        if (!mounted) return;
        Nav.pop(context);
      }
    }
  }
}
