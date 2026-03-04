import 'package:captcha/logic.dart';
import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

Widget captchaWidget() => stateWidget(CaptchaLogic.new, _Build.new);

class _Build extends Build<CaptchaLogic> {
  _Build(super.logic);

  @override
  Widget build() {
    return UiPage(
      title: const Text('captcha'),
      body: Center(
        child: UiButton(
          onTap: logic.onCaptchaTap,
          child: const Text('captcha'),
        ),
      ),
    );
  }
}