import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UiCaptcha extends StatefulWidget {
  final String url;
  final Future<bool> Function(String param) verifyParam;

  const UiCaptcha({super.key, required this.url, required this.verifyParam});

  @override
  State<UiCaptcha> createState() => _UiCaptchaState();
}

class _UiCaptchaState extends State<UiCaptcha> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    final bridge = "_b${Random().nextInt(100)}_";
    controller = WebViewController();
    controller.runJavaScript('''
      const _dartCallbacks = {};
      window._dartCallback = (callbackId, result) =>{
          if (_dartCallbacks[callbackId]) {
              _dartCallbacks[callbackId](result);
              delete _dartCallbacks[callbackId];
          }
      }
      function verify(param) {
          return new Promise((resolve) => {
              const callbackId = 'cb_' + Date.now() + '_' + Math.random().toString(36).substring(2);
              _dartCallbacks[callbackId] = resolve;
              const payload = {
                  callbackId,
                  param,
              };
              $bridge.postMessage(JSON.stringify(payload));
          });
      }
    ''');
    controller.addJavaScriptChannel(
      bridge,
      onMessageReceived: (JavaScriptMessage message) async {
        final data = jsonDecode(message.message);
        final callbackId = data['callbackId'];
        final param = data['param'];
        final result = await widget.verifyParam(param);
        final script = '''
                window._dartCallback('$callbackId', ${result?'true':'false'});
              ''';
        controller.runJavaScript(script);
      },
    );
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) => WebViewWidget(controller: controller);
}
