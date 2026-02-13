import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:ui_alert/ui_alert.dart';
import 'package:ui_app/src/widget.dart';
import 'package:ui_toast/ui_toast.dart';

Future<void> uiApp({
  required Widget home,
  String? title,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  //增加图片缓存
  PaintingBinding.instance.imageCache.maximumSizeBytes = 500 << 20; // 500MB
  //状态栏
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Color(0x00000000),
      systemNavigationBarColor: Color(0x00000000),
    ),
  );

  // 强制应用占满全屏（包括状态栏和导航栏区域）
  //await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  //关闭键盘
  await SystemChannels.textInput.invokeMethod('TextInput.hide');

  //竖屏
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final navigatorKey = GlobalKey<NavigatorState>();

  //导航
  FnNav.navigatorKey = navigatorKey;

  //toast
  UiToast.navigatorKey = navigatorKey;

  //alert
  UiAlert.navigatorKey = navigatorKey;

  runApp(
    App(
      navigatorKey: navigatorKey,
      title: title,
      home: home,
    ),
  );
}
