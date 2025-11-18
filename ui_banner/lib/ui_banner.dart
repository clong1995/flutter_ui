import 'dart:async';

import 'package:device/device.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UiBanner extends StatefulWidget {
  const UiBanner({
    super.key,
    required this.children,
    this.auto = true,
    this.indicator = true,
    this.scrollDirection = Axis.horizontal,
  });

  final bool auto;
  final bool indicator;
  final Axis scrollDirection;
  final List<Widget> children;

  @override
  State<UiBanner> createState() => _UiBannerState();
}

class _UiBannerState extends State<UiBanner>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  PageController? pageController;
  TabController? indicatorController;

  Timer? ticker;
  int index = 0;
  bool isScrolling = true;
  bool isCurrentPage = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  @override
  void didUpdateWidget(UiBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.children.length != widget.children.length ||
        oldWidget.auto != widget.auto ||
        oldWidget.indicator != widget.indicator ||
        oldWidget.scrollDirection != widget.scrollDirection) {
      _dispose();
      _init();
    }
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _dispose();
  }

  void _init(){
    if (widget.children.length > 1) {
      pageController = PageController(initialPage: 0);
    }

    if (widget.indicator) {
      indicatorController = TabController(
        length: widget.children.length,
        vsync: this,
      );
    }

    if (widget.auto && widget.children.length > 1) {
      ticker = tickerStart();
    }
  }

  void _dispose() {
    pageController?.dispose();
    pageController = null;
    indicatorController?.dispose();
    indicatorController = null;
    ticker?.cancel();
    ticker = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (widget.auto && widget.children.length > 1) {
      if (state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused) {
        ticker?.cancel();
      } else if (state == AppLifecycleState.resumed) {
        ticker = tickerStart();
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    bool isCurrent = ModalRoute.of(context)?.isCurrent ?? false;
    if (isCurrent && !isCurrentPage) {
      //防止重复启动
      isCurrentPage = true;
      ticker = tickerStart();
    } else {
      if (!isCurrent) {
        ticker?.cancel();
        isCurrentPage = false;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.children.length > 1
        ? Stack(
            children: [
              regionWrap(
                child: PageView.builder(
                  itemCount: null,
                  scrollDirection: widget.scrollDirection,
                  controller: pageController,
                  itemBuilder: (BuildContext context, int index) =>
                      widget.children[index % widget.children.length],
                  onPageChanged: onPageChanged,
                ),
              ),
              if (indicatorController != null)
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
                        controller: indicatorController,
                        tabs: List<Widget>.generate(
                          widget.children.length,
                          (int index) => const SizedBox(width: 24),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          )
        : widget.children.length == 1
        ? widget.children[0]
        : const SizedBox.shrink();
  }

  void onPageChanged(int index) {
    if (indicatorController != null) {
      this.index = index;
      indicatorController?.animateTo(index % widget.children.length);
    }
  }

  Timer tickerStart() {
    ticker?.cancel();
    return Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (widget.children.isEmpty) {
        return;
      }
      if (indicatorController != null) {
        index += 1;
        int p = index % widget.children.length;
        indicatorController?.animateTo(p);
      }
      pageController?.nextPage(
        duration: kTabScrollDuration,
        curve: Curves.ease,
      );
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
        onTapDown: (TapDownDetails detail) {
          if (widget.auto) {
            ticker?.cancel();
          }
        },
        onTapUp: (TapUpDetails detail) {
          if (widget.auto) {
            ticker = tickerStart();
          }
        },
        child: child,
      );
    }
    return MouseRegion(
      onEnter: (PointerEnterEvent event) {
        if (widget.auto) {
          ticker?.cancel();
        }
      },
      onExit: (PointerExitEvent event) {
        if (widget.auto) {
          ticker = tickerStart();
        }
      },
      child: child,
    );
  }
}
