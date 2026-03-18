import 'package:flutter/material.dart';

class UiSimulator {
  UiSimulator._();

  static Widget ios(BuildContext context, Widget? child) {
    return child == null
        ? const SizedBox.shrink()
        : _UiSimulator(context, child);
  }

  static Widget android(BuildContext context, Widget? child) {
    return child == null
        ? const SizedBox.shrink()
        : _UiSimulator(
            context,
            child,
            device: _Device.android,
          );
  }

  static Widget web(BuildContext context, Widget? child) {
    return child == null
        ? const SizedBox.shrink()
        : _UiSimulator(
            context,
            child,
            device: _Device.web,
          );
  }
}

enum _Device { ios, android, web }

//尺寸: 340 * 740
class _UiSimulator extends StatelessWidget {
  const _UiSimulator(
    this.context,
    this.child, {
    //super.key,
    this.device = _Device.ios,
  });

  final _Device device;

  // final Widget Function(BuildContext) builder;
  final BuildContext context;
  final Widget child;

  double get paddingTop => 35;

  double get paddingBottom => 25;

  double get indicatorHeight => 5;

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final padding = EdgeInsets.fromLTRB(
      0,
      device == _Device.web ? 0 : paddingTop,
      0,
      paddingBottom,
    );
    return MediaQuery(
      data: mediaQueryData.copyWith(
        viewPadding: padding,
        padding: padding,
        textScaler: TextScaler.noScaling,
        size: const Size(340, 740),
      ),
      child: DefaultTextStyle(
        style: const TextStyle(color: Colors.black),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                children: [
                  if (device == _Device.web)
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(top: paddingTop),
                      height: paddingTop * 2,
                      alignment: Alignment.center,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: paddingTop * .85,
                        width: mediaQueryData.size.width * .95,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(227, 227, 227, 1),
                          //border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.lock,
                              color: Colors.green,
                              size: 14,
                            ),
                            const Expanded(
                              child: Center(
                                child: Text(
                                  'Web Simulator',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Icon(
                              Icons.refresh,
                              size: 14,
                              color: Colors.grey.shade700,
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
                  const Expanded(
                    child: Center(
                      child: Text(
                        '14:15',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  if (device == _Device.ios)
                    Container(
                      width: mediaQueryData.size.width / 2,
                      // height: paddingTop * 95,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: paddingTop * .1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Container(
                            width: 50,
                            height: 6,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.circle,
                                color: Colors.grey.shade900,
                                size: 14,
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
                  const Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.signal_cellular_alt, size: 17),
                        SizedBox(width: 6),
                        Icon(Icons.wifi, size: 17),
                        SizedBox(width: 6),
                        RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.battery_5_bar, size: 18),
                        ),
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //bottom
            if (device == _Device.ios)
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
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(indicatorHeight / 2),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
