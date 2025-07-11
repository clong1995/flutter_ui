import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'common.dart';

class UiCacheImage extends StatefulWidget {
  final String src;
  final BoxFit? fit;

  const UiCacheImage(this.src, {super.key, this.fit});

  @override
  State<UiCacheImage> createState() => _UiCacheImageState();
}

class _UiCacheImageState extends State<UiCacheImage> {
  /*static const Duration cacheDuration = Duration(minutes: 5);
  static final Map<String, _CacheEntry> imageCache = {};*/

  late Future<Widget> futureImage;

  late String src;

  @override
  void initState() {
    super.initState();
    //cleanUpCache(); // 初始化时清理过期缓存
    src = widget.src;
    futureImage = _cachedImage(widget.src, widget.fit);
  }

  @override
  void didUpdateWidget(covariant UiCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src || oldWidget.fit != widget.fit) {
      debugPrint("image changed");
      src = widget.src;
      futureImage = _cachedImage(src, widget.fit);
      setState(() {});
    }
  }

  /*Future<Widget> getCachedImage(String src, BoxFit? fit) {
    final now = DateTime.now();
    // 如果缓存存在并未过期，则返回缓存，并刷新过期时间
    if (imageCache.containsKey(src)) {
      final cacheEntry = imageCache[src]!;
      if (cacheEntry.expiry.isAfter(now)) {
        cacheEntry.expiry = now.add(cacheDuration); // 刷新过期时间
        return cacheEntry.imageFuture;
      } else {
        imageCache.remove(src); // 过期，移除缓存
      }
    }

    // 如果没有缓存或已过期，重新加载
    final future = _tempImage(src, fit);
    imageCache[src] = _CacheEntry(future, now.add(cacheDuration));

    return future;
  }*/

  Future<Widget> _cachedImage(String src, BoxFit? fit) async {
    if (kIsWeb) {
      return Image.network(src, fit: fit);
    }

    final tempDir = await tempDirectory();
    final md5 = md5str(src);
    final imageFile = File('$tempDir/$md5');

    if (await imageFile.exists()) {
      return Image.file(imageFile, fit: fit);
    }

    //请求新的图片
    debugPrint("request new image");

    final response = await get(Uri.parse(src));
    if (response.statusCode == 200) {
      await imageFile.writeAsBytes(response.bodyBytes);
      return Image.memory(response.bodyBytes, fit: fit);
    }

    debugPrint("request new image error: ${response.statusCode}");

    return const Icon(Icons.image_outlined);
  }

  /// 清理过期的缓存项
  /*void cleanUpCache() {
    final now = DateTime.now();
    imageCache.removeWhere((_, entry) => entry.expiry.isBefore(now));
  }*/

  @override
  Widget build(BuildContext context) => FutureBuilder<Widget>(
    future: futureImage,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        debugPrint(snapshot.error.toString());
        return const Icon(Icons.broken_image);
      } else if (snapshot.hasData) {
        return snapshot.data!;
      } else {
        return const Icon(Icons.image);
      }
    },
  );
}

/*class _CacheEntry {
  Future<Widget> imageFuture;
  DateTime expiry;

  _CacheEntry(this.imageFuture, this.expiry);
}*/
