import 'package:flutter_test/flutter_test.dart';
import 'package:untitled/untitled.dart';
import 'package:untitled/untitled_platform_interface.dart';
import 'package:untitled/untitled_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockUntitledPlatform
    with MockPlatformInterfaceMixin
    implements UntitledPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final UntitledPlatform initialPlatform = UntitledPlatform.instance;

  test('$MethodChannelUntitled is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelUntitled>());
  });

  test('getPlatformVersion', () async {
    Untitled untitledPlugin = Untitled();
    MockUntitledPlatform fakePlatform = MockUntitledPlatform();
    UntitledPlatform.instance = fakePlatform;

    expect(await untitledPlugin.getPlatformVersion(), '42');
  });
}
