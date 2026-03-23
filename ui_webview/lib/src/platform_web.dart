import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UiWebview extends StatefulWidget {
  const UiWebview({required this.url, this.register, super.key});

  final String url;

  //这个不会用到
  final Map<String, Future<dynamic> Function(dynamic json)>? register;

  @override
  State<UiWebview> createState() => _UiWebviewState();
}

class _UiWebviewState extends State<UiWebview> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    unawaited(initWebview());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: Center(child: Text('加载中...')),
        ),
        WebViewWidget(controller: controller),
      ],
    );
  }

  Future<void> initWebview() async {
    controller = WebViewController();
    if (widget.url.startsWith('http://') || widget.url.startsWith('https://')) {
      await controller.loadRequest(Uri.parse(widget.url));
    } else {
      await controller.loadFlutterAsset(widget.url);
    }
  }
}
