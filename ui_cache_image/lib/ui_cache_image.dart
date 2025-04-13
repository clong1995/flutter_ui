import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

String _cacheDirectory = "";

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

  @override
  void initState() {
    super.initState();
    //cleanUpCache(); // 初始化时清理过期缓存
    futureImage = _cachedImage(widget.src, widget.fit);
  }

  @override
  void didUpdateWidget(covariant UiCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src || oldWidget.fit != widget.fit) {
      if (kDebugMode) {
        print("image changed");
      }
      futureImage = _cachedImage(widget.src, widget.fit);
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

    String tempDirectory = await _tempDirectory();
    String md5str = _md5str(src);
    File imageFile = File('$tempDirectory/$md5str');

    if (await imageFile.exists()) {
      return Image.file(imageFile, fit: fit);
    }

    //请求新的图片
    if (kDebugMode) {
      print("request new image");
    }
    Response response = await get(Uri.parse(src));
    if (response.statusCode == 200) {
      await imageFile.writeAsBytes(response.bodyBytes);
      return Image.memory(response.bodyBytes, fit: fit);
    }

    if (kDebugMode) {
      print("request new image error: ${response.statusCode}");
    }
    return const Icon(Icons.image_outlined);
  }

  Future<String> _tempDirectory() async {
    if(_cacheDirectory.isNotEmpty){
      return _cacheDirectory;
    }
    final dir = await getTemporaryDirectory();
    _cacheDirectory = dir.path;
    return _cacheDirectory;
  }

  String _md5str(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  /// 清理过期的缓存项
  /*void cleanUpCache() {
    final now = DateTime.now();
    imageCache.removeWhere((_, entry) => entry.expiry.isBefore(now));
  }*/

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: futureImage,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          if (kDebugMode) {
            print(snapshot.error);
          }
          return const Icon(Icons.broken_image);
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return const Icon(Icons.image);
        }
      },
    );
  }
}

/*class _CacheEntry {
  Future<Widget> imageFuture;
  DateTime expiry;

  _CacheEntry(this.imageFuture, this.expiry);
}*/
