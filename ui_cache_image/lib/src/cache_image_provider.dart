import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';

String _cacheDirectory = "";

class UiCacheImageProvider extends ImageProvider<UiCacheImageProvider> {
  final String src;

  UiCacheImageProvider(this.src);

  @override
  Future<UiCacheImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<UiCacheImageProvider>(this);
  }

  // Flutter 3.0+ 使用 loadBuffer 或 loadImage
  @override
  ImageStreamCompleter loadImage(
    UiCacheImageProvider key,
    ImageDecoderCallback decode,
  ) {
    final chunkEvents = StreamController<ImageChunkEvent>();
    return MultiFrameImageStreamCompleter(
      chunkEvents: chunkEvents.stream,
      codec: _loadAsync(key, chunkEvents, decode),
      scale: 1.0,
      debugLabel: 'AsyncImageProvider($src)',
    );
  }

  Future<ui.Codec> _loadAsync(
    UiCacheImageProvider key,
    StreamController<ImageChunkEvent> chunkEvents,
    ImageDecoderCallback decode,
  ) async {
    try {
      String tempDirectory = await _tempDirectory();
      String md5str = _md5str(src);
      File imageFile = File('$tempDirectory/$md5str');
      if (await imageFile.exists()) {
        final bytes = await imageFile.readAsBytes();
        return await _bytesToCodec(bytes);
      }
      //请求新的图片
      if (kDebugMode) {
        print("request new image");
      }

      Response response = await get(Uri.parse(src));
      if (response.statusCode == 200) {
        await imageFile.writeAsBytes(response.bodyBytes);
        return await _bytesToCodec(response.bodyBytes);
      }

      if (kDebugMode) {
        print("request new image error: ${response.statusCode}");
      }
      final ByteData data = await rootBundle.load("images/image.png");
      final Uint8List bytes = data.buffer.asUint8List();
      return await _bytesToCodec(bytes);
    } catch (e) {
      // 处理加载错误
      debugPrint('Failed to load image: $e');
      rethrow;
    } finally {
      await chunkEvents.close();
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UiCacheImageProvider && other.src == src;
  }

  @override
  int get hashCode => src.hashCode;

  Future<ui.Codec> _bytesToCodec(Uint8List bytes) async {
    final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
    final descriptor = await ui.ImageDescriptor.encoded(buffer);
    final codec = await descriptor.instantiateCodec();
    buffer.dispose();
    descriptor.dispose();
    return codec;
  }
}

String _md5str(String input) => md5.convert(utf8.encode(input)).toString();

Future<String> _tempDirectory() async {
  if (_cacheDirectory.isNotEmpty) {
    return _cacheDirectory;
  }
  final dir = await getTemporaryDirectory();
  _cacheDirectory = dir.path;
  return _cacheDirectory;
}
