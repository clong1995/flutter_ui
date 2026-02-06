import 'dart:async';

import 'package:dependency/dependency.dart';
import 'package:flutter/widgets.dart';

class _State {
  int seconds = 0;
}

class SplashLogic extends Logic<_State> {
  SplashLogic(super.context);

  @override
  void onInit() {
    super.onInit();
    state = _State();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_loadData());
    });
  }

  Future<void> _loadData() async {
    _startTimer(()=>Package.pushAndRemovePackage('home'));
  }

  void _startTimer(void Function() callback) {
    if (state.seconds > 0) {
      Timer.periodic(const Duration(milliseconds: 300), (timer) {
        if (state.seconds > 0) {
          state.seconds--;
          update([const ValueKey('jump')]);
        } else {
          timer.cancel();
          callback();
        }
      });
    } else {
      callback();
    }
  }
}
