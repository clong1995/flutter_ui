import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 生成二维码
Widget uiQrGenerate(
  String data, {
  double size = 200,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
  Color backgroundColor = const Color(0xFFFFFFFF),
  Color foregroundColor = const Color(0xFF000000),
  int errorCorrectionLevel = QrErrorCorrectLevel.M,
}) {
  final painter = QrPainter(
    data: data,
    version: QrVersions.auto,
    errorCorrectionLevel: errorCorrectionLevel,
    eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: foregroundColor),
    dataModuleStyle: QrDataModuleStyle(
      dataModuleShape: QrDataModuleShape.square,
      color: foregroundColor,
    ),
  );

  return Padding(
    padding: padding,
    child: SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: painter,
        child: ColoredBox(color: backgroundColor),
      ),
    ),
  );
}
