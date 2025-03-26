import 'dart:async';

import 'package:device/device.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UiBanner extends StatefulWidget {
  const UiBanner({
    super.key,
    this.auto = false,
    required this.children,
  });

  final bool auto;
  final List<Widget> children;

  @override
  State<UiBanner> createState() => _UiBannerState();
}

class _UiBannerState extends State<UiBanner>
    with SingleTickerProviderStateMixin {
  late PageController pageController;
  late TabController tabController;
  Timer? ticker;
  int index = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: 0,
    );
    tabController = TabController(length: widget.children.length, vsync: this);
    if(widget.auto){
      ticker = tickerStart();
    }
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    tabController.dispose();
    ticker?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        regionWrap(
          child: PageView.builder(
            controller: pageController,
            itemBuilder: (BuildContext context, int index) =>
                widget.children[index % widget.children.length],
            onPageChanged: onPageChanged,
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: IgnorePointer(
              child: TabBar(
                tabAlignment: TabAlignment.center,
                labelPadding: EdgeInsets.zero,
                dividerHeight: 0,
                indicatorColor: Theme.of(context).primaryColor,
                controller: tabController,
                tabs: List<Widget>.generate(
                  widget.children.length,
                  (int index) => const SizedBox(width: 24),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onPageChanged(int index) {
    this.index = index;
    tabController.animateTo(index % widget.children.length);
  }

  Timer tickerStart() {
    return Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      index += 1;
      int p = index % widget.children.length;
      tabController.animateTo(p);
      pageController.animateToPage(p,
          duration: kTabScrollDuration, curve: Curves.ease);
    });
  }

  Widget regionWrap({required Widget child}) {
    bool touch = false;
    String platform = Device.platform;
    switch (platform) {
      case "web-ios":
      case "web-android":
        touch = true;
        break;
      case "web-windows":
      case "web-macOS":
      case "web-linux":
      case "web-fuchsia":
        touch = false;
        break;
      case "android":
      case "iOS":
        touch = true;
        break;
      case "windows":
      case "macOS":
      case "linux":
      case "fuchsia":
        touch = false;
        break;
    }
    if (touch) {
      return GestureDetector(
        onTapDown: (TapDownDetails detail){
          ticker?.cancel();
        },
        onTapUp: (TapUpDetails detail){
          ticker = tickerStart();
        },
        child: child,
      );
    }
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        ticker?.cancel();
      },
      onExit: (PointerExitEvent event) {
        ticker = tickerStart();
      },
      child: child,
    );
  }
}
