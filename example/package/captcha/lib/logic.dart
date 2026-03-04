import 'package:dependency/dependency.dart';

class _State {}

class CaptchaLogic extends Logic<_State> {
  CaptchaLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  void onCaptchaTap() {
    uiCaptcha(
      context: context,
      verify: (String json) async => true,
    );
  }
}
