import 'dart:async';

import 'package:dependency/dependency.dart';

class _State {}

class ToastLogic extends Logic<_State> {
  ToastLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  void onSuccessTap() {
    UiToast.show(UiToastMessage.success());
  }

  void onInfoTap() {
    UiToast.show(UiToastMessage.info());
  }

  void onFailureTap() {
    UiToast.show(UiToastMessage.failure());
  }

  void onChoiceTap() {
    UiToast.show(
      UiToastMessage.failure()
        ..text = '是否重试'
        ..autoPopSeconds = 0
        ..callback = (value) {
          logger('$value');
        },
    );
  }

  void onLoadingTap() {
    final pop = UiToast.show(UiToastMessage.loading());
    Future.delayed(const Duration(seconds: 10), pop);
  }

  void onCustomTap() {
    UiToast.show(
      UiToastMessage()
        ..text = '自定义文本'
        ..icon = const FaIcon(FontAwesomeIcons.fontAwesome),
    );
  }
}
