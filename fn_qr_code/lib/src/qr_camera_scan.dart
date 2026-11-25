import 'dart:async';

import 'package:fn_device/fn_device.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rpx/ext.dart';

/// 摄像头扫码
class _QrCameraScan extends StatefulWidget {
  const new();

  @override
  State<_QrCameraScan> createState() => _QrCameraScanState();
}

class _QrCameraScanState extends State<_QrCameraScan> {
  late final MobileScannerController _controller;

  bool _handled = false;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: const [BarcodeFormat.qrCode],
    );
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    if (_handled) return;

    String? value;

    for (final barcode in capture.barcodes) {
      if (barcode.rawValue != null) {
        value = barcode.rawValue;
        break;
      }
    }

    if (value == null) return;

    _handled = true;

    await _controller.stop();

    if (!mounted) return;

    FnNav.pop<String?>(result: value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MobileScanner(controller: _controller, onDetect: _onDetect),
        Positioned(
          top: FnDevice.statusBarHeight + 10.r,
          left: 20.r,
          child: GestureDetector(
            onTap: FnNav.pop,
            child: Container(
              width: 40.r,
              height: 40.r,
              alignment: .center,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: .circular(20.r),
              ),
              child: Icon(Icons.close, color: Colors.white, size: 20.r),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    unawaited(_controller.dispose());
    super.dispose();
  }
}

Future<String?> qrCameraScan() async =>
    await FnNav.push<String?>(_QrCameraScan.new);
