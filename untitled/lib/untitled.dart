
import 'untitled_platform_interface.dart';

class Untitled {
  Future<String?> getPlatformVersion() {
    return UntitledPlatform.instance.getPlatformVersion();
  }
}
