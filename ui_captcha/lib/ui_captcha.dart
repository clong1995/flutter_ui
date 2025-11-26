import 'package:flutter/material.dart';
import 'package:ui_alert/ui_alert.dart' show alertCustom;
import 'package:ui_webview/ui_webview.dart';

Future<void> uiCaptcha({
  required BuildContext context,
  required Future<bool> Function(String json) verify,
  double width = 340,
  double height = 340,
}) async => alertCustom(
  context: context,
  child: _Captcha(verify: verify, width: width, height: height),
);

class _Captcha extends StatelessWidget {
  const _Captcha({
    required this.verify,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final Future<bool> Function(String json) verify;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        Expanded(
          child: UiWebview(
            url: 'packages/ui_captcha/html/captcha.html',
            register: {
              'verify': (dynamic data) async {
                final res = await verify(data.toString());
                if (res && context.mounted) {
                  Navigator.pop(context);
                }
                return res;
              },
            },
          ),
        ),
        const SizedBox(height: 5),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            '取消验证',
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  );
}
