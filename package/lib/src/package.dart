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
    final packageBuilder = _packages[packageName];

    return packageBuilder == null
        ? const SizedBox.shrink()
        : packageBuilder(
            arg: arg,
          );
  }

  //注册包，在项目初始化的时候统一注册
  static void register(Iterable<Register Function()> builders) {
    for (final register in builders) {
      final package = register();
      if (_packages.containsKey(package.name)) {
        throw FormatException('${package.name} already registered');
      }
      _packages[package.name] = package.packageBuilder;
    }
  }
}
