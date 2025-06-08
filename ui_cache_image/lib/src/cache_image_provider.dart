import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

import 'common.dart';

class UiCacheImageProvider extends ImageProvider<UiCacheImageProvider> {
  final String src;

  UiCacheImageProvider(this.src);

  @override
  Future<UiCacheImageProvider> obtainKey(ImageConfiguration configuration) =>
      SynchronousFuture<UiCacheImageProvider>(this);

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
      final tempDir = await tempDirectory();
      final md5 = md5str(src);
      final imageFile = File('$tempDir/$md5');
      if (await imageFile.exists()) {
        try {
          final bytes = await imageFile.readAsBytes();
          return await ui.instantiateImageCodec(bytes);
        } catch (e) {
          debugPrint('cache image error $e');
          await imageFile.delete();
        }
      }

      //请求新的图片
      debugPrint("request new image");

      final response = await get(Uri.parse(src));
      if (response.statusCode != 200) {
        throw Exception('status code: ${response.statusCode}');
      } else if (response.bodyBytes.isEmpty) {
        throw Exception('response body is empty');
      }

      await imageFile.writeAsBytes(response.bodyBytes);
      return await ui.instantiateImageCodec(response.bodyBytes);
    } catch (e) {
      final data = await rootBundle.load(
        "packages/ui_cache_image/images/image.png",
      );
      final bytes = data.buffer.asUint8List();
      return await ui.instantiateImageCodec(bytes);
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
}
