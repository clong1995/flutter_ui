import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'untitled_method_channel.dart';

abstract class UntitledPlatform extends PlatformInterface {
  /// Constructs a UntitledPlatform.
  UntitledPlatform() : super(token: _token);

  static final Object _token = Object();

  static UntitledPlatform _instance = MethodChannelUntitled();

  /// The default instance of [UntitledPlatform] to use.
  ///
  /// Defaults to [MethodChannelUntitled].
  static UntitledPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [UntitledPlatform] when
  /// they register themselves.
  static set instance(UntitledPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
