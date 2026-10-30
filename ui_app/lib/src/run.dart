import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:fn_datetime/fn_datetime.dart';
import 'package:fn_device/fn_device.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:rpx/ext.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_app/src/widget.dart';
import 'package:ui_theme/ui_theme.dart';
import 'package:ui_toast/ui_toast.dart';
import 'package:window_manager/window_manager.dart';

Future<void> uiApp({
  required Widget home,
  String? title,
  Widget Function(BuildContext, Widget?)? builder,
  Desktop? desktop,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  //提前设置宽度
  setViewWidth();
  UiTheme.fontSize = 13.r;

  if (desktop != null &&
      (FnDevice.platform == PlatformType.macOS ||
          FnDevice.platform == PlatformType.linux ||
          FnDevice.platform == PlatformType.windows)) {
    //单实例
    await windowManager.ensureInitialized();
    if (!await FlutterSingleInstance().isFirstInstance()) {
      final err = await FlutterSingleInstance().focus();
      if (err != null) {
        if (kDebugMode) {
          print(err);
        }
      }
      exit(0);
    }

    //检查分辨率
    final display = PlatformDispatcher.instance.views.first.display;
    final pixelRatio = display.devicePixelRatio;
    final physicalWidth = display.size.width;
    final physicalHeight = display.size.height;

    //逻辑分辨率
    final dprWidth = physicalWidth / pixelRatio;
    final dprHeight = physicalHeight / pixelRatio;

    //
    var width = desktop.width;
    var height = desktop.height;

    //留出安全
    final safeWidth = (dprWidth * .9).floorToDouble();
    final safeHeight = (dprHeight * .9).floorToDouble();

    //cover算法
    if (safeWidth <= width || safeHeight <= height) {
      final scaleW = safeWidth / desktop.width;
      final scaleH = safeHeight / desktop.height;
      final scale = min(scaleW, scaleH);
      width = width * scale;
      height = height * scale;
    }

    //规定桌面显示
    setViewWidth(width);
    UiTheme.fontSize = desktop.fontSize ?? 10.r;

    final size = Size(width, height);

    final windowOptions = WindowOptions(
      size: size,
      minimumSize: size,
      center: true,
      titleBarStyle: desktop.titleBar ? null : TitleBarStyle.hidden,
    );

    await windowManager.waitUntilReadyToShow(windowOptions, () async {
      if(!desktop.resizable){
        await windowManager.setResizable(desktop.resizable);
        await windowManager.setMaximizable(false);
      }
      await windowManager.show();
      await windowManager.focus();
    });
  } else if (FnDevice.platform == PlatformType.iOS ||
      FnDevice.platform == PlatformType.android) {
    //状态栏
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: UiTheme.transparent,
        systemNavigationBarColor: UiTheme.transparent,
      ),
    );

    // 强制应用占满全屏
    // 包括状态栏和导航栏区域，光靠removePadding 和 safeArea 没法覆盖底部手势指示器
    await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    //关闭键盘
    await SystemChannels.textInput.invokeMethod('TextInput.hide');

    //竖屏
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  //增加图片缓存
  PaintingBinding.instance.imageCache.maximumSizeBytes = 500 << 20; // 500MB

  //本地时间显示
  await FnDatetime.setLocale();

  //屏幕常亮
  if (!kIsWeb) {
    await FnDevice.lockEnable();
  }

  final navigatorKey = GlobalKey<NavigatorState>();

  //导航
  FnNav.navigatorKey = navigatorKey;

  //toast
  UiToast.navigatorKey = navigatorKey;

  //alert
  UiAlert.navigatorKey = navigatorKey;

  runApp(
    App(navigatorKey: navigatorKey, title: title, home: home, builder: builder),
  );
}

class Desktop {
  new({
    this.width = 1152,
    this.height = 720,
    this.titleBar = true,
    this.resizable = true,
    this.fontSize,
  });

  final double width;
  final double height;
  final bool titleBar;
  final bool resizable;
  final double? fontSize;
}
