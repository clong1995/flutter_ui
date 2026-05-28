import 'dart:async';

import 'package:dependency/dependency.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';

class _State {}

class ToastLogic extends Logic<_State> {
  ToastLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  Future<void> onSuccessTap() async {
    final res = await UiToast.show(UiToastMessage.success());
    print(res);
  }

  Future<void> onInfoTap() async {
    await UiToast.show(UiToastMessage.info());
  }

  Future<void> onFailureTap() async {
    await UiToast.show(UiToastMessage.failure());
  }

  Future<void> onChoiceTap() async {
    final res = await UiToast.show(
      UiToastMessage.failure()
        ..text = '是否重试'
        ..autoPopSeconds = 0
        ..select = true,
    );
    print(res);
  }

  void onLoadingTap() {
    final pop = UiToast.showLoading();
    Future.delayed(const Duration(seconds: 10), pop);
  }

  Future<void> onCustomTap() async {
    await UiToast.show(
      UiToastMessage()
        ..text = '自定义文本'
        ..icon = const Icon(Icons.flutter_dash),
    );
  }
}
