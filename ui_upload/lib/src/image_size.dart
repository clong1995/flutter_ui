import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

class ImageSize {
  int width = 0;
  int height = 0;
}

Future<ImageSize> imageSize(File file) async {
  /*final image = Image.file(file);
  final completer = Completer<Size>();
  image.image
      .resolve(ImageConfiguration.empty)
      .addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          final size = info.image;
          completer.complete(
            Size(size.width.toDouble(), size.height.toDouble()),
          );
        }),
      );
  return completer.future;*/

  final bytes = await file.readAsBytes();
  final codec = await instantiateImageCodec(
    bytes,
    targetWidth: 1,
    targetHeight: 1,
  );

  final frame = await codec.getNextFrame();
  return ImageSize()
    ..width = frame.image.width
    ..height = frame.image.height;
}

Future<ImageSize> imageSizeFromBytes(Uint8List imageBytes) async {
  /*final image = Image.memory(imageBytes);
  final completer = Completer<Size>();
  image.image
      .resolve(ImageConfiguration.empty)
      .addListener(
        ImageStreamListener((ImageInfo info, bool _) {
          final size = info.image;
          completer.complete(
            Size(size.width.toDouble(), size.height.toDouble()),
          );
        }),
      );
  return completer.future;*/

  final codec = await instantiateImageCodec(
    imageBytes,
    targetWidth: 1,
    targetHeight: 1,
  );
  final frame = await codec.getNextFrame();
  return ImageSize()
    ..width = frame.image.width
    ..height = frame.image.height;
}
