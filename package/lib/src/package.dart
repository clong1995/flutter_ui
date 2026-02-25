import 'package:flutter/cupertino.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:package/package.dart';

class Package {

  static Widget get(String packageName){
    return Register.get(packageName)();
  }

  static Future<T?> push<T extends Object?>(
      String packageName, {
        bool root = false,
        Object? args,
      }) {
    final page = Register.get(packageName);
    return FnNav.push<T>(page, root: root, args: args);
  }

  static Future<T?> pushAndRemove<T extends Object?>(
      String packageName, {
        bool root = false,
        Object? args,
      }) {
    final page = Register.get(packageName);
    return FnNav.pushAndRemove<T>(page, root: root, args: args);
  }
}
