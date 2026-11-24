import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// 摄像头扫码
class UiQrCameraScan extends StatefulWidget {
  const new({
    required this.onResult, super.key,
    this.fit = BoxFit.cover,
  });

  final ValueChanged<String> onResult;
  final BoxFit fit;

  @override
  State<UiQrCameraScan> createState() => _UiQrCameraScanState();
}

class _UiQrCameraScanState extends State<UiQrCameraScan> {
  late final MobileScannerController _controller;

  bool _handled = false;

  @override
  void initState() {
    super.initState();

    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      formats: const [
        BarcodeFormat.qrCode,
      ],
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

    widget.onResult(value);
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: _controller,
      fit: widget.fit,
      onDetect: _onDetect,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
