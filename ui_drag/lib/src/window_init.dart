import 'dart:ui';

import 'package:window_manager/window_manager.dart';

Future<void> windowInit(Size size) async {
  await windowManager.ensureInitialized();
  windowManager.waitUntilReadyToShow(
    WindowOptions(
      size: size,
      titleBarStyle: TitleBarStyle.hidden,
      windowButtonVisibility: false,
    ),
    () async {
      await windowManager.show();
      await windowManager.setMinimumSize(size);
      await windowManager.focus();
    },
  );
}
