import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'package:ui_cache_image/src/common.dart';

class UiCacheImage extends StatefulWidget {

  const UiCacheImage(this.src, {super.key, this.fit});
  final String src;
  final BoxFit? fit;

  @override
  State<UiCacheImage> createState() => _UiCacheImageState();
}

class _UiCacheImageState extends State<UiCacheImage> {
  Widget? image;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    //print("initState");
     unawaited(loadImage());
  }

  Future<void> loadImage() async {
    image = await cachedImage(widget.src, widget.fit);
    setState(() => loading = false);
  }

  @override
  void didUpdateWidget(covariant UiCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src || oldWidget.fit != widget.fit) {
      debugPrint('image changed');
      setState(() => loading = true);
      unawaited(loadImage());
    }
  }

  Future<Widget> cachedImage(String src, BoxFit? fit) async {
    if (kIsWeb) {
      return Image.network(src, fit: fit);
    }

    final tempDir = await tempDirectory();
    final md5 = md5str(src);
    final imageFile = File('$tempDir/$md5');

    if (imageFile.existsSync()) {
      return Image.file(imageFile, fit: fit);
    }

    //请求新的图片
    debugPrint('request new image');

    final response = await get(Uri.parse(src));
    if (response.statusCode == 200) {
      await imageFile.writeAsBytes(response.bodyBytes);
      return Image.memory(response.bodyBytes, fit: fit);
    }

    debugPrint('request new image error: ${response.statusCode}');

    return const Icon(Icons.image_outlined);
  }

  @override
  Widget build(BuildContext context) {
    //print(loading);
    if (loading) return const Center(child: CircularProgressIndicator());
    return image ?? const Icon(Icons.broken_image);
  }
}
