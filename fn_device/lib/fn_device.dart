import 'package:flutter/foundation.dart';
import 'package:fn_device/src/guid/guid.dart';
import 'package:fn_device/src/user_agent/user_agent.dart';

class FnDevice {
  FnDevice._();

  static String? _platform;
  static String? _guid;
  static String? _info;

  static String get platform {
    if (_platform != null) {
      return _platform!;
    }
    if (kIsWeb) {
      if (userAgent.contains('iPad') ||
          userAgent.contains('iPhone') ||
          userAgent.contains('iPod')) {
        _platform = 'web-ios';
      } else if (userAgent.contains('Android')) {
        _platform = 'web-android';
      } else if (userAgent.contains('Windows')) {
        _platform = 'web-windows';
      } else if (userAgent.contains('macOS')) {
        _platform = 'web-macOS';
      } else if (userAgent.contains('linux')) {
        _platform = 'web-linux';
      } else if (userAgent.contains('fuchsia')) {
        _platform = 'web-fuchsia';
      }
    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          _platform = 'android';
        case TargetPlatform.iOS:
          _platform = 'iOS';
        case TargetPlatform.windows:
          _platform = 'windows';
        case TargetPlatform.macOS:
          _platform = 'macOS';
        case TargetPlatform.linux:
          _platform = 'linux';
        case TargetPlatform.fuchsia:
          _platform = 'fuchsia';
      }
    }
    return _platform ?? 'no-os';
  }

  static Future<String> get guid async {
    if (_guid != null) {
      return _guid!;
    }
    return Guid.id;
  }

  static Future<String> get info async {
    if (_info != null) {
      return _info!;
    }
    return Guid.info;
  }
}
