import 'dart:math';
import 'dart:ui';

import 'package:fn_device/fn_device.dart';

Size shortestSize (){
  final display = PlatformDispatcher.instance.views.first.display;
  final pixelRatio = display.devicePixelRatio;
  //物理分辨率
  final physicalWidth = display.size.width;
  final physicalHeight = display.size.height;
  //逻辑分辨率
  final dprWidth = physicalWidth / pixelRatio;
  final dprHeight = physicalHeight / pixelRatio;

  if (FnDevice.platform == PlatformType.macOS ||
      FnDevice.platform == PlatformType.linux ||
      FnDevice.platform == PlatformType.windows ||
      FnDevice.platform == PlatformType.fuchsia ||
      FnDevice.platform == PlatformType.webMacOS ||
      FnDevice.platform == PlatformType.webLinux ||
      FnDevice.platform == PlatformType.webWindows ||
      FnDevice.platform == PlatformType.webFuchsia
  ) {
    //桌面端设计分辨率
    const designWidth = 1152.0;
    const designHeight = 720.0;

    //留出安全
    final safeWidth = (dprWidth * .9).floorToDouble();
    final safeHeight = (dprHeight * .9).floorToDouble();

    //cover算法
    if (safeWidth <= designWidth || safeHeight <= designHeight) {
      final scaleW = safeWidth / designWidth;
      final scaleH = safeHeight / designHeight;
      final scale = min(scaleW, scaleH);
      final width = designWidth * scale;
      final height = designHeight * scale;
      return Size(width, height);
    }
    return const Size(designWidth, designHeight);
  }else if (FnDevice.platform == PlatformType.iOS ||
      FnDevice.platform == PlatformType.android ||
      FnDevice.platform == PlatformType.webAndroid ||
      FnDevice.platform == PlatformType.webIOS
  ) {
    if (dprWidth > 600) {
      //平板
      return Size(dprWidth/2, dprHeight/2);
    }
    return Size(dprWidth, dprWidth);
  }

  return Size(dprWidth, dprWidth);
}