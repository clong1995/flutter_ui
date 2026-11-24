import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// 生成二维码
Widget uiQrGenerate(
  String data, {
  double size = 200,
  EdgeInsets padding = EdgeInsets.zero,
  Color backgroundColor = const Color(0xFFFFFFFF),
  Color foregroundColor = const Color(0xFF000000),
  int errorCorrectionLevel = QrErrorCorrectLevel.M,
}) {
  return QrImageView(
    data: data,
    size: size,
    padding: padding,
    backgroundColor: backgroundColor,
    errorCorrectionLevel: errorCorrectionLevel,

    // 定位眼颜色
    eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.square, color: foregroundColor),

    // 数据模块颜色
    dataModuleStyle: QrDataModuleStyle(
      dataModuleShape: QrDataModuleShape.square,
      color: foregroundColor,
    ),
  );
}
