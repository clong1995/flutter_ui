import 'package:flutter/widgets.dart';
import 'package:package/src/register.dart';

class Package {
  static final Map<
    String,
    Widget Function({
      Object? arg,
    })
  >
  _packages = {};

  //获取一个包
  static Widget package(String packageName, {Object? arg}) {
    if (!_packages.containsKey(packageName)) {
      throw FormatException('$packageName not registered');
    }
    final package = _packages[packageName];
    if (package == null) {
      throw FormatException('$packageName is null');
    }
    return package(
      arg: arg,
    );
  }

  //注册包，在项目初始化的时候统一注册
  static void register(Iterable<Register Function()> builders) {
    for (final builder in builders) {
      final package = builder();
      if (_packages.containsKey(package.name)) {
        throw FormatException('${package.name} already registered');
      }
      _packages[package.name] = package.builder;
    }
  }
}
