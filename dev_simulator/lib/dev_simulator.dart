import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DevSimulator extends StatelessWidget {
  const DevSimulator({
    super.key,
    required this.child,
  });

  final Widget child;
  final double paddingTop = 35;
  final double paddingBottom = 26;

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.windows ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      MediaQueryData mediaQueryData = MediaQuery.of(context);
      return MediaQuery(
        data: mediaQueryData.copyWith(
          padding: mediaQueryData.padding
              .copyWith(top: paddingTop, bottom: paddingBottom),
        ),
        child: Scaffold(
          body: Stack(
            children: [
              child,
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  children: [
                    const Expanded(
                      child: Center(
                        child: Text("14:15"),
                      ),
                    ),
                    Container(
                      width: 180,
                      height: paddingTop,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(22),
                          bottomRight: Radius.circular(22),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Container(
                            width: 12,
                            height: 12,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          Container(
                            width: 60,
                            height: 8,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                          )
                        ],
                      ),
                    ),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.signal_cellular_alt,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.wifi,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.battery_5_bar,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: paddingBottom - 14,
                // bottom: 10,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 5,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return child;
  }
}
