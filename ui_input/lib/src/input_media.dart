/*
import 'package:flutter/material.dart';

class UiInputMedia extends StatefulWidget {
  const UiInputMedia({
    required this.uploadUrl,
    required this.list,
    this.onChanged, //不传无法使用
    this.crossAxisCount = 3,
    super.key,
    this.axisSpacing = 5,
    this.limit = 9, //1 常用于上传头像等

    this.icon = Icons.add_photo_alternate_outlined,

    //仅图片有效
    this.imageQuality,
    this.maxHeight,
    this.maxWidth,
    this.decoration,

    //仅仅视频有效
    //xxx

    // 根据不同的扩展名，弹窗有变化，比如包含pdf，则会多一个文件选择按钮
    //音频： 'mp3', 'wav', 'aac', 'm4a', 'ogg'
    //图片： 'jpg', 'jpeg', 'png', 'gif', 'bmp'
    //视频：'mp4', 'mov', 'avi', 'mkv'
    //文档：'pdf', 'doc', 'docx', 'ppt', 'pptx','txt', 'rtf'
    //null：默认不限制
    this.ext,
  });

  final int crossAxisCount;
  final void Function(List<String> images)? onChanged;
  final Future<List<NetUrl>?> Function(List<String> fileName) uploadUrl;
  final double axisSpacing;
  final List<String> list;
  final double? maxWidth;
  final double? maxHeight;
  final int? imageQuality;
  final int limit;
  final List<String>? ext;
  final IconData icon;
  final Decoration? decoration;

  @override
  State<UiInputMedia> createState() => _UiInputMediaState();
}

class _UiInputMediaState extends State<UiInputMedia> {
  late Color primaryColor;
  late BoxDecoration decoration;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    primaryColor = Theme.of(context).primaryColor;
    decoration = BoxDecoration(
      border: Border.all(color: primaryColor),
      borderRadius: BorderRadius.circular(8),
      color: primaryColor.withAlpha(10),
    );
    return widget.limit <= 1 ? single() : multiple();
  }

  Widget multiple() => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    primary: false,
    padding: EdgeInsets.zero,
    itemCount: widget.list.length + 1,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: widget.crossAxisCount,
      mainAxisSpacing: widget.axisSpacing,
      crossAxisSpacing: widget.axisSpacing,
    ),
    itemBuilder: (BuildContext context, int index) {
      return index == widget.list.length
          ? GestureDetector(
              //onTap: onMultiTap,
              child: DecoratedBox(
                decoration: widget.decoration ?? decoration,
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      widget.icon,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
            )
          : DecoratedBox(
              decoration: widget.decoration ?? decoration,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  GestureDetector(
                    onTap: () async {
                      //await imageWidget(index);
                    },
                    */
/*child: UiCacheImage(
                      imageList[index],
                      fit: BoxFit.contain,
                    ),*//*

                  ),
                  //removeWidget(index),
                ],
              ),
            );
    },
  );

  Widget single() => AspectRatio(
    aspectRatio: 1,
    child: DecoratedBox(
      decoration: widget.decoration ?? decoration,
      child: widget.list.isNotEmpty
          ? Stack(
              children: [
                //removeWidget(index),
                //UiCacheImage(imageList[0], fit: BoxFit.contain)
                Container(
                  color: Colors.red,
                ),
              ],
            )
          //if (widget.list.isNotEmpty) removeWidget(0),
          : FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Icon(
                  widget.icon,
                  color: primaryColor,
                ),
              ),
            ),
    ),
  );
}

class NetUrl {
  String upload = '';
  String download = '';
}
*/
