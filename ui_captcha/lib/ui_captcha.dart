import 'package:flutter/material.dart';
import 'package:ui_alert/ui_alert.dart' show custom;
import 'package:ui_webview/ui_webview.dart';

Future<void> captcha({
  required BuildContext context,
  required Future<bool> Function(String json) verify,
  double width = 300,
  double height = 420,
}) async => await custom(
  context: context,
  child: _Captcha(verify: verify, width: width, height: height),
);

class _Captcha extends StatelessWidget {
  final double width;
  final double height;
  final Future<bool> Function(String json) verify;

  const _Captcha({required this.verify, required this.width, required this.height});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        Expanded(
          child: UiWebview(
            url: "packages/system/html/captcha.html",
            register: {
              "verify": (dynamic data) async {
                bool res = await verify(data);
                if (res && context.mounted) {
                  Navigator.pop(context);
                }
                return res;
              },
            },
          ),
        ),
        SizedBox(height: 5),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("取消验证"),
        ),
        SizedBox(height: 10),
      ],
    ),
  );
}
