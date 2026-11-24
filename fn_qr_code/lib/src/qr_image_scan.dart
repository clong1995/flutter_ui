import 'package:image/image.dart' as img;
import 'package:ui_pick_file/ui_pick_file.dart';
import 'package:zxing2/qrcode.dart';

/// 从图片识别二维码
Future<String?> fnQrImageScan() async {
  final pf = await UiPickFile.single();
  if (pf == null) {
    return null;
  }

  final bytes = await pf.bytes();
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
