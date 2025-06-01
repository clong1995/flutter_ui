import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

String _cacheDirectory = "";

Future<ImageProvider<Object>> uiCacheImageProvider(String src) async {
  String tempDirectory = await _tempDirectory();
  String md5str = _md5str(src);
  File imageFile = File('$tempDirectory/$md5str');
  if (await imageFile.exists()) {
    return FileImage(imageFile);
  }
  //请求新的图片
  if (kDebugMode) {
    print("request new image");
  }

  Response response = await get(Uri.parse(src));
  if (response.statusCode == 200) {
    await imageFile.writeAsBytes(response.bodyBytes);
    return MemoryImage(response.bodyBytes);
  }
  if (kDebugMode) {
    print("request new image error: ${response.statusCode}");
  }
  return const AssetImage("images/image.png");
}

String _md5str(String input) {
  return md5.convert(utf8.encode(input)).toString();
}

Future<String> _tempDirectory() async {
  if (_cacheDirectory.isNotEmpty) {
    return _cacheDirectory;
  }
  final dir = await getTemporaryDirectory();
  _cacheDirectory = dir.path;
  return _cacheDirectory;
}