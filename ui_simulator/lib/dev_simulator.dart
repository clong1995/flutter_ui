import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_theme/ui_theme.dart';

enum UiSimulatorDevice {
  ios,
  android, //还没有
  web
}

//尺寸: 340 * 740
class UiSimulator extends StatelessWidget {
  const UiSimulator(
    this.context,
    this.child, {
    super.key,
    //super.key,
    this.device = UiSimulatorDevice.ios,
  });

  final UiSimulatorDevice device;

  // final Widget Function(BuildContext) builder;
  final BuildContext context;
  final Widget child;

  double get paddingTop => 35.r;

  double get paddingBottom => 25.r;

  double get indicatorHeight => 5.r;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final padding = EdgeInsets.fromLTRB(
      0,
      device == UiSimulatorDevice.web ? 0 : paddingTop,
      0,
      device == UiSimulatorDevice.web ? 0 :paddingBottom,
    );
    return MediaQuery(
      data: mediaQueryData.copyWith(
        viewPadding: padding,
        padding: padding,
        textScaler: TextScaler.noScaling,
        //TODO ?
        //size: Size(340, 740),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                if (device == UiSimulatorDevice.web)
                  Container(
                    color: UiTheme.white,
                    padding: EdgeInsets.only(top: paddingTop),
                    height: paddingTop * 2,
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      height: paddingTop * .85,
                      width: mediaQueryData.size.width * .95,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(227, 227, 227, 1),
                        //border: Border.all(color: UiTheme.grey.shade300),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lock,
                            color: UiTheme.green,
                            size: 14.r,
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                'Web Simulator',
                                style: TextStyle(
                                  fontSize: 14.r,
                                ),
                              ),
                            ),
                          ),
                          Icon(
                            Icons.refresh,
                            size: 14.r,
                            color: UiTheme.gary700,
                          ),
                        ],
                      ),
                    ),
                  ),
                //Expanded(child: Builder(builder: builder)),
                Expanded(child: child),
              ],
            ),
          ),
          //top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: paddingTop,
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      '14:15',
                      style: TextStyle(
                        fontSize: 14.r,
                      ),
                    ),
                  ),
                ),
                if (device == UiSimulatorDevice.ios)
                  Container(
                    width: mediaQueryData.size.width / 2,
                    // height: paddingTop * 95,
                    decoration: BoxDecoration(
                      color: UiTheme.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(22.r),
                        bottomRight: Radius.circular(22.r),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: paddingTop * .1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Spacer(),
                        Container(
                          width: 50.r,
                          height: 6.r,
                          margin: EdgeInsets.symmetric(horizontal: 5.r),
                          decoration: BoxDecoration(
                            color: UiTheme.gary800,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.circle,
                              color: UiTheme.gary900,
                              size: 14.r,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                else
                  SizedBox(
                    width: mediaQueryData.size.width / 2,
                  ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 17.r),
                      SizedBox(width: 6.r),
                      Icon(Icons.wifi, size: 17.r),
                      SizedBox(width: 6.r),
                      RotatedBox(
                        quarterTurns: 1,
                        child: Icon(Icons.battery_5_bar, size: 18.r),
                      ),
                      SizedBox(width: 10.r),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //bottom
          if (device == UiSimulatorDevice.ios)
            Positioned(
              height: paddingBottom,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: indicatorHeight,
                  width: mediaQueryData.size.width / 2,
                  decoration: BoxDecoration(
                    color: UiTheme.black,
                    borderRadius: BorderRadius.circular(indicatorHeight / 2),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
