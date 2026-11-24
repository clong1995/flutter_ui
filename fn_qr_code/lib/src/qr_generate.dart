import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ui_pick_file/ui_pick_file.dart';

// 生成二维码
Widget uiQrGenerate(
  String data, {
  double size = 200,
  int errorCorrectionLevel = QrErrorCorrectLevel.M,
  bool save = false,
}) {
  final painter = QrPainter(
    data: data,
    version: QrVersions.auto,
    errorCorrectionLevel: errorCorrectionLevel,
  );

  return GestureDetector(
    onTap: save
        ? () async {
            final byteData = await painter.toImageData(512);
            if (byteData == null) return;

            final bytes = byteData.buffer.asUint8List(
              byteData.offsetInBytes,
              byteData.lengthInBytes,
            );

            final timestamp = DateTime.now().millisecondsSinceEpoch;

            await UiPickImage.save(bytes: bytes, fileName: 'qrcode_$timestamp');
          }
        : null,
    child: SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: painter),
    ),
  );
}
