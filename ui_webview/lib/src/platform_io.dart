import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
//import 'package:webview_flutter_android/webview_flutter_android.dart';

class UiWebview extends StatefulWidget {
  const UiWebview({super.key, this.url = '', this.html = '', this.register});

  final String url; //"packages/ui_captcha/html/captcha.html","https://pub.dev"
  final String html;
  final Map<String, Future<dynamic> Function(dynamic json)>? register;

  @override
  State<UiWebview> createState() => _UiWebviewState();
}

class _UiWebviewState extends State<UiWebview> {
  late WebViewController controller;

  bool pageReady = false;

  @override
  void initState() {
    super.initState();
    unawaited(initWebview());
  }

  Future<void> initWebview() async {
    //chrome://inspect/#devices
    //AndroidWebViewController.enableDebugging(true);

    controller = WebViewController();
    await controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    //
    final bridge = '_b${random}_';
    final callback = '_cb${random}_';
    if (isRegister) {
      await controller.addJavaScriptChannel(
        bridge,
        onMessageReceived: (message) async {
          final data = jsonDecode(message.message);
          final callbackId = data['callbackId'];
          final action = data['action'];
          final param = data['param'];

          final func = widget.register![action];
          var res = '';
          if (func == null) {
            res = '$action : not found';
          }

          final result = await func!(param);
          res = jsonEncode(result);
          final script =
              '''
                window.$callback('$callbackId', $res);
              ''';
          await controller.runJavaScript(script);
        },
      );
    }

    //ready
    final ready = '_r${random}_';
    await controller.addJavaScriptChannel(
      ready,
      onMessageReceived: (message) async {
        setState(() {
          pageReady = true;
        });
      },
    );

    await controller.setNavigationDelegate(
      NavigationDelegate(
        /*onProgress: (int progress) {
          // Update loading bar.
        },*/
        onPageFinished: (url) async {
          var script =
              '''
              (function() {
                if (document.readyState === "complete") {
                  $ready.postMessage("");
                } else {
                  window.addEventListener("load", ()=>$ready.postMessage(""));
                }
              })();
          ''';
          //有函数需要调用时
          if (isRegister) {
            final callbacks = '_cbs${random}_';
            script +=
                '''
              const $callbacks = {};
              window.$callback = (callbackId, result)=>{
                  if ($callbacks[callbackId]) {
                      $callbacks[callbackId](result);
                      delete $callbacks[callbackId];
                  }
              };
              
              window.wv = (action,param) =>{
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
              };
            ''';
          }
          await controller.runJavaScript(script);
        },
      ),
    );
    if (widget.html.isNotEmpty) {
      await controller.loadHtmlString(widget.html);
    } else if (widget.url.startsWith('http://') || widget.url.startsWith('https://')) {
      await controller.loadRequest(Uri.parse(widget.url));
    } else {
      await controller.loadFlutterAsset(widget.url);
    }
  }

  int get random => Random().nextInt(100);

  bool get isRegister => widget.register != null && widget.register!.isNotEmpty;

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      WebViewWidget(controller: controller),
      if (!pageReady)
        const Positioned.fill(
          child: Center(child: Text('加载中...')),
        ),
    ],
  );
}
