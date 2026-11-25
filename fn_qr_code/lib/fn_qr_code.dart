import 'package:flutter/cupertino.dart';
import 'package:fn_qr_code/src/qr_camera_scan.dart';
import 'package:fn_qr_code/src/qr_generate.dart';
import 'package:fn_qr_code/src/qr_image_scan.dart';
import 'package:qr_flutter/qr_flutter.dart';

class FnQrCode {
  new _();

  static Future<String?> cameraScan() => qrCameraScan();

  static Widget generate(
    String data, {
    double size = 200,
    int errorCorrectionLevel = QrErrorCorrectLevel.M,
    bool save = false,
  }) => qrGenerate(
    data,
    size: size,
    errorCorrectionLevel: errorCorrectionLevel,
    save: save,
  );

  static Future<String?> imageScan() => qrImageScan();
}
