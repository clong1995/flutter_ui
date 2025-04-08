import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UiWebview extends StatefulWidget {
  final String url;
  final Map<String, Future<dynamic> Function(dynamic json)>? register;

  const UiWebview({super.key, required this.url, this.register});

  @override
  State<UiWebview> createState() => _UiWebviewState();
}

class _UiWebviewState extends State<UiWebview> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController();
    //有函数需要调用时
    if (widget.register != null && widget.register!.isNotEmpty) {
      final bridge = "_b${random}_";
      final callbacks = "_cbs${random}_";
      final callback = "_cb${random}_";
      controller.runJavaScript('''
        const $callbacks = {};
        window.$callback = (callbackId, result) =>{
            if ($callbacks[callbackId]) {
                $callbacks[callbackId](result);
                delete $callbacks[callbackId];
            }
        }
        function wvCall(action,param) {
            return new Promise((resolve) => {
                const callbackId = 'cb_' + Date.now() + '_' + Math.random().toString(36).substring(2);
                $callbacks[callbackId] = resolve;
                const payload = {
                    callbackId,
                    action,
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
          final action = data['action'];
          final param = data['param'];

          final func = widget.register![action];
          String res = "";
          if (func == null) {
            res = "$action : not found";
          }

          final result = await func!(param);
          res = jsonEncode(result);
          final script = '''
                window.$callback('$callbackId', $res);
              ''';
          controller.runJavaScript(script);
        },
      );
    }
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.loadRequest(Uri.parse(widget.url));
  }

  int get random => Random().nextInt(100);

  @override
  Widget build(BuildContext context) => WebViewWidget(controller: controller);
}
