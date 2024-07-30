library ui_banner;

import 'dart:async';
import 'dart:js' as js;

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UIBanner extends StatefulWidget {
  const UIBanner({
    super.key,
    required this.child,
  });

  final List<Widget> child;

  @override
  State<UIBanner> createState() => _UIBannerState();
}

class _UIBannerState extends State<UIBanner>
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
    tabController = TabController(length: widget.child.length, vsync: this);
    ticker = tickerStart();
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
        MouseRegion(
          onEnter: (PointerEnterEvent event) {
            ticker?.cancel();
          },
          onExit: (PointerExitEvent event) {
            ticker = tickerStart();
          },
          child: PageView.builder(
            controller: pageController,
            itemBuilder: (BuildContext context, int index) =>
                widget.child[index % widget.child.length],
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
                  widget.child.length,
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
    tabController.animateTo(index % widget.child.length);
  }

  Timer tickerStart() {
    return Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      index += 1;
      int p = index % widget.child.length;
      tabController.animateTo(p);
      pageController.animateToPage(p,
          duration: kTabScrollDuration, curve: Curves.ease);
    });
  }

  Widget regionWrap() {
    bool touch = false;
    if (kIsWeb) {
      var userAgent = js.context["navigator"]["userAgent"];

    } else {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          touch = true;
          break;
        case TargetPlatform.iOS:
          touch = true;
          break;
        case TargetPlatform.windows:
        case TargetPlatform.macOS:
        case TargetPlatform.linux:
        case TargetPlatform.fuchsia:
          touch = false;
          break;
        default:
          touch = true;
          break;
      }
    }

    return Text("");
  }
}
