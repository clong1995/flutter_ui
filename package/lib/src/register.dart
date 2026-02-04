import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';

typedef PkgReg = Map<String, Widget Function()>;

class Register {
  Register._();

  static late PkgReg _pkgReg;

  //获取一个包
  static Widget Function() get(String packageName) {
    final package = _pkgReg[packageName];
    if (package == null) {
      return () => ErrorWidget('$packageName not registered');
    }
    return package;
  }

  // 注册包，在项目初始化的时候统一注册
  // ignore:avoid_setters_without_getters
  static set pkgReg(PkgReg value) {
    _pkgReg = value;
  }
}
