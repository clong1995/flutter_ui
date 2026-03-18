import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_webview/ui_webview.dart';

Future<void> uiCaptcha({
  required BuildContext context,
  required Future<bool> Function(String json) verify,
}) async => UiAlert.dialog(
  () => _Captcha(verify: verify),
);

class _Captcha extends StatelessWidget {
  const _Captcha({
    required this.verify,
  });

  final Future<bool> Function(String json) verify;

  @override
  Widget build(BuildContext context) {
    return UiAlertWidget(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: px(context, 325),
            height: px(context, 290),
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
          UiTextButton(
            onTap: () => Navigator.pop(context),
            text: '取消验证',
          ),
        ],
      ),
    );
  }

  double px(BuildContext context, double size) {
    print(MediaQuery.of(context).devicePixelRatio);
    return size;
  }
}
