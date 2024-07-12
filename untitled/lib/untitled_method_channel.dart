import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'untitled_platform_interface.dart';

/// An implementation of [UntitledPlatform] that uses method channels.
class MethodChannelUntitled extends UntitledPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('untitled');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
