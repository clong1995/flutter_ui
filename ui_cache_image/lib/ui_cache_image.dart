import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class UiCacheImage extends StatefulWidget {
  final String src;
  final BoxFit? fit;
  const UiCacheImage(this.src,{super.key, this.fit});

  @override
  State<UiCacheImage> createState() => _UiCacheImageState();
}

class _UiCacheImageState extends State<UiCacheImage> {
  static final Map<String, Future<Widget>> _imageCache = {};

  late Future<Widget> _futureImage;

  @override
  void initState() {
    super.initState();
    _futureImage = _getCachedImage(widget.src, widget.fit);
  }

  @override
  void didUpdateWidget(covariant UiCacheImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src || oldWidget.fit != widget.fit) {
      setState(() {
        _futureImage = _getCachedImage(widget.src, widget.fit);
      });
    }
  }

  Future<Widget> _getCachedImage(String src, BoxFit? fit) {
    return _imageCache.putIfAbsent(src, () => _tempImage(src, fit));
  }

  static Future<Widget> _tempImage(String src, BoxFit? fit) async {
    if (kIsWeb) {
      return Image.network(src, fit: fit);
    }

    String tempDirectory = await _tempDirectory();
    String md5str = _md5str(src);
    File imageFile = File('$tempDirectory/$md5str');

    if (await imageFile.exists()) {
      return Image.file(imageFile, fit: fit);
    }

    Response response = await get(Uri.parse(src));
    if (response.statusCode == 200) {
      await imageFile.writeAsBytes(response.bodyBytes);
      return Image.memory(response.bodyBytes, fit: fit);
    }

    return const Icon(Icons.image_outlined);
  }

  static Future<String> _tempDirectory() async {
    final dir = await getTemporaryDirectory();
    return dir.path;
  }

  static String _md5str(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _futureImage,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
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
