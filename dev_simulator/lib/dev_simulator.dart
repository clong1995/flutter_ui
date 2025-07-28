import 'package:flutter/material.dart';

//尺寸: 340 * 740
class DevSimulator extends StatelessWidget {
  const DevSimulator(this.builder, {super.key});

  final Widget Function(BuildContext) builder;

  final double paddingTop = 35;
  final double paddingBottom = 25;
  final double indicatorHeight = 5;

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: MediaQuery(
              data: mediaQueryData.copyWith(
                viewPadding: mediaQueryData.padding.copyWith(
                  top: paddingTop,
                  bottom: paddingBottom,
                ),
              ),
              child: Builder(builder: builder),
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
                    child: Text("14:15", style: TextStyle(fontSize: 12)),
                  ),
                ),
                Container(
                  width: mediaQueryData.size.width / 2,
                  height: paddingTop * .9,
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
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.signal_cellular_alt, size: 17),
                      SizedBox(width: 5),
                      Icon(Icons.wifi, size: 17),
                      SizedBox(width: 5),
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
    );
  }
}

// 34
// 896 740
