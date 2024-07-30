import 'package:flutter/foundation.dart';
import 'src/user_agent.dart';

class Device {
  static String? _platform;

  static String get platform {
    if (_platform != null) {
      return _platform ?? "";
    }
    if (kIsWeb) {
      if (userAgent.contains('iPad') ||
          userAgent.contains('iPhone') ||
          userAgent.contains('iPod')) {
        _platform = "web-ios";
      } else if (userAgent.contains('Android')) {
        _platform = "web-android";
      } else if (userAgent.contains('Windows')) {
        _platform = "web-windows";
      } else if (userAgent.contains('macOS')) {
        _platform = "web-macOS";
      } else if (userAgent.contains('linux')) {
        _platform = "web-linux";
      } else if (userAgent.contains('fuchsia')) {
        _platform = "web-fuchsia";
      }
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _platform = "android";
          break;
        case TargetPlatform.iOS:
          _platform = "iOS";
          break;
        case TargetPlatform.windows:
          _platform = "windows";
          break;
        case TargetPlatform.macOS:
          _platform = "macOS";
          break;
        case TargetPlatform.linux:
          _platform = "linux";
          break;
        case TargetPlatform.fuchsia:
          _platform = "fuchsia";
          break;
      }
    }
    return _platform ?? "";
  }
}
