import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:fn_device/src/guid/guid.dart';
import 'package:fn_device/src/height.dart';
import 'package:fn_device/src/user_agent/user_agent.dart';
import 'package:fn_device/src/wake_lock.dart';

class FnDevice {
  new _();

  static PlatformType? _platform;
  static String? _brand;
  static String? _guid;
  static String? _info;

  static PlatformType get platform {
    if (_platform != null) {
      return _platform!;
    }
    if (kIsWeb) {
      if (userAgent.contains('iPad') ||
          userAgent.contains('iPhone') ||
          userAgent.contains('iPod')) {
        _platform = PlatformType.webIOS;
      } else if (userAgent.contains('Android')) {
        _platform = PlatformType.webAndroid;
      } else if (userAgent.contains('Windows')) {
        _platform = PlatformType.webWindows;
      } else if (userAgent.contains('macOS')) {
        _platform = PlatformType.webMacOS;
      } else if (userAgent.contains('linux')) {
        _platform = PlatformType.webLinux;
      } else if (userAgent.contains('fuchsia')) {
        _platform = PlatformType.webFuchsia;
      }
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _platform = PlatformType.android;
        case TargetPlatform.iOS:
          _platform = PlatformType.iOS;
        case TargetPlatform.windows:
          _platform = PlatformType.windows;
        case TargetPlatform.macOS:
          _platform = PlatformType.macOS;
        case TargetPlatform.linux:
          _platform = PlatformType.linux;
        case TargetPlatform.fuchsia:
          _platform = PlatformType.fuchsia;
      }
    }
    return _platform ?? PlatformType.unknown;
  }

  //Apple、Xiaomi、Redmi、HUAWEI、HONOR、OPPO、OnePlus、vivo、Meizu、samsung
  static Future<String> get brand async {
    if (_brand != null) {
      return _brand!;
    }
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      _brand = 'Apple';
    } else {
      final info = await DeviceInfoPlugin().androidInfo;
      _brand = info.brand;
    }
    return _brand ?? 'no-brand';
  }

  static Future<String> get guid async {
    if (_guid != null) {
      return _guid!;
    }
    return await Guid.id;
  }

  static Future<String> get info async {
    if (_info != null) {
      return _info!;
    }
    return await Guid.info;
  }

  static Future<void> Function() lockEnable = wakeLockEnable;

  static Future<void> Function() lockDisable = wakeLockDisable;

  static double get statusBarHeight {
    return Height.statusBarHeight;
  }

  static double get bottomSafeHeight {
    return Height.bottomSafeHeight;
  }
}

enum PlatformType {
  android('Android'),
  iOS('iOS'),
  windows('Windows'),
  macOS('macOS'),
  linux('Linux'),
  fuchsia('Fuchsia'),
  webIOS('Web-iOS'),
  webAndroid('Web-Android'),
  webWindows('Web-Windows'),
  webMacOS('Web-macOS'),
  webLinux('Web-Linux'),
  webFuchsia('Web-Fuchsia'),
  unknown('');

  new(this.label);

  /// 平台的显示名称
  final String label;

  @override
  String toString() => label;
}
