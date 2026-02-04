import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:package/src/register.dart';

class Package {
  Package._();

  static final Map<String, Widget Function()> _packages = {};

  //获取一个包
  static Widget Function() _get(String packageName) {
    final package = _packages[packageName];
    if (package == null) {
      return ()=>ErrorWidget('$packageName not registered');
    }
    return package;
  }

  static Future<T?> pushPackage<T extends Object?>(
    String packageName, {
    bool root = false,
    Object? args,
  }) {
    final page = _get(packageName);
    return FnNav.push<T>(page, root: root, args: args);
  }

  static Future<T?> pushAndRemovePackage<T extends Object?>(
    String packageName, {
    bool root = false,
    Object? args,
  }) {
    final page = _get(packageName);
    return FnNav.pushAndRemove<T>(page, root: root, args: args);
  }

  //注册包，在项目初始化的时候统一注册
  static void register(PkgReg pkgReg) {
    for (final builder in pkgReg) {
      final package = builder();
      if (_packages.containsKey(package.name)) {
        throw FormatException('${package.name} already registered');
      }
      _packages[package.name] = package.builder;
    }
  }
}
