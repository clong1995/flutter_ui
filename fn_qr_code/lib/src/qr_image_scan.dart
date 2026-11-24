import 'dart:typed_data';

import 'package:image/image.dart' as img;
import 'package:zxing2/qrcode.dart';

/// 从图片识别二维码
String? qrImageScan(Uint8List bytes) {
  final image = img.decodeImage(bytes);

  if (image == null) return null;

  try {
    final rgba = image.convert(numChannels: 4);

    final source = RGBLuminanceSource(
      image.width,
      image.height,
      rgba.getBytes(order: img.ChannelOrder.abgr).buffer.asInt32List(),
    );

    final bitmap = BinaryBitmap(GlobalHistogramBinarizer(source));

    return QRCodeReader().decode(bitmap).text;
  } on Exception {
    return null;
  }
}
