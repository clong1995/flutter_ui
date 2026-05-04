import 'package:wakelock_plus/wakelock_plus.dart';

Future<void> wakeLockEnable() async {
  await WakelockPlus.enable();
}

Future<void> wakeLockDisable() async {
  await WakelockPlus.disable();
}
