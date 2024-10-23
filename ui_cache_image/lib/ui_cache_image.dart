import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

class UiCacheImage extends StatelessWidget {
  final String src;
  final BoxFit? fit;

  static Future<String>? _tempDirectoryFuture;

  const UiCacheImage(
    this.src, {
    super.key,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    //print("build");
    return FutureBuilder<Widget>(
      future: _tempImage(src, fit),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          //print(snapshot.error);
          return const Icon(
            Icons.broken_image,
            color: Colors.red,
          );
        } else if (snapshot.hasData) {
          return snapshot.data!; // 显示数据
        } else {
          return const Icon(
            Icons.image,
            color: Colors.red,
          );
        }
      },
    );
  }

  static Future<String> _tempDirectory() {
    if (_tempDirectoryFuture != null) {
      return _tempDirectoryFuture!;
    }
    // print("new future");
    _tempDirectoryFuture =
        getTemporaryDirectory().then((Directory dir) => dir.path);
    return _tempDirectoryFuture!;
  }

  Future<Widget> _tempImage(String src, BoxFit? fit) async {
    String tempDirectory = await _tempDirectory();
    String md5str = _md5str(src);
    File imageFile = File('$tempDirectory/$md5str');
    bool exists = await imageFile.exists();
    if (exists) {
      //print("cache");
      return Image.file(
        imageFile,
        fit: fit,
      );
    }
    //print("load");
    Response response = await get(Uri.parse(src));
    if (response.statusCode == 200) {
      imageFile.writeAsBytes(response.bodyBytes);
      return Image.memory(
        response.bodyBytes,
        fit: fit,
      );
    }
    return const Icon(
      Icons.image_outlined,
      color: Colors.red,
    );
  }

  String _md5str(String input) {
    Uint8List bytes = utf8.encode(input);
    Digest digest = md5.convert(bytes);
    return digest.toString();
  }
}
