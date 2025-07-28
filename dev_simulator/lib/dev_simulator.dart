import 'package:flutter/material.dart';

//尺寸: 340 * 740
class DevSimulator extends StatelessWidget {
  final bool web; //模拟web
  final String webTitle; //模拟web
  const DevSimulator(
    this.builder, {
    super.key,
    this.web = false,
    this.webTitle = "example.com",
  });

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
                  top: web == true ? 0 : paddingTop,
                  bottom: paddingBottom,
                ),
              ),
              child: Column(
                children: [
                  if (web == true)
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
                            Expanded(
                              child: Center(child: Text(webTitle)),
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
                  Expanded(child: Builder(builder: builder)),
                ],
              ),
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
