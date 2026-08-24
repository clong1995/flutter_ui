import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:material_ui/material_ui.dart' show Icons;
import 'package:ui_cache_image/src/common.dart';

class UiCacheImage extends StatefulWidget {
  const UiCacheImage(this.src, {super.key, this.fit, this.thumbnail = false});

  final String src;
  final BoxFit? fit;
  final bool thumbnail;

  @override
  State<UiCacheImage> createState() => _UiCacheImageState();
}

class _UiCacheImageState extends State<UiCacheImage> {
  late Widget image;
  bool loading = true;

  int _loadId = 0;

  @override
  void initState() {
    super.initState();
    unawaited(loadImage());
  }

  Future<void> loadImage() async {
    final loadId = ++_loadId;

    final result = await cachedImage(
      src: widget.src,
      fit: widget.fit,
      thumbnail: widget.thumbnail,
    );

    if (!mounted || loadId != _loadId) {
      return;
    }

    setState(() {
      image = result;
      loading = false;
    });
  }

  @override
  void didUpdateWidget(covariant UiCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src ||
        oldWidget.fit != widget.fit ||
        oldWidget.thumbnail != widget.thumbnail) {
      if (oldWidget.src != widget.src) {
        debugPrint('image src changed');
        setState(() => loading = true);
      }
      unawaited(loadImage());
    }
  }

  Future<Widget> cachedImage({
    required String src,
    required BoxFit? fit,
    required bool thumbnail,
  }) async {
    var imgSrc = src;

    if (thumbnail) {
      final original = Uri.parse(imgSrc);
      final uri = original.replace(
        queryParameters: {
          ...original.queryParameters,
          'x-oss-process': 'style/thumbnail',
        },
      );
      imgSrc = uri.toString();
    }

    if (kIsWeb) {
      return Image.network(
        imgSrc,
        fit: fit,
        gaplessPlayback: true,
      );
    }

    final tempDir = await tempDirectory();

    final md5 = md5str(imgSrc);
    final imageFile = File('$tempDir/$md5');

    if (imageFile.existsSync()) {
      return Image.file(
        imageFile,
        fit: fit,
        gaplessPlayback: true,
      );
    }

    //请求新的图片
    debugPrint('request new image');

    final response = await get(Uri.parse(imgSrc));

    if (response.statusCode == 200) {
      await imageFile.writeAsBytes(response.bodyBytes);
      return Image.memory(
        response.bodyBytes,
        fit: fit,
        gaplessPlayback: true,
      );
    }

    debugPrint('request new image error: ${response.statusCode}');

    return const Icon(Icons.broken_image_outlined);
  }

  @override
  Widget build(BuildContext context) {
    //print(loading);
    if (loading) {
      return const Center(
        child: Icon(
          Icons.downloading,
        ),
      );
    }
    return image;
  }
}
