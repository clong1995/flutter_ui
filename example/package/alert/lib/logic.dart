import 'package:alert/widget.dart' show Dialog;
import 'package:dependency/dependency.dart';
import 'package:flutter/cupertino.dart';

class _State {}

class AlertLogic extends Logic<_State> {
  AlertLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
  }

  Future<void> onDialogTap() async {
    await UiAlert.dialog(Dialog.new);
  }

  Future<void> onCustomTap() async {
    await UiAlert.custom(
      builder: () {
        return Text('data');
      },
      title: 'custom',
    );
  }
}
