library ui_banner;

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

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.child.length * 10);
    tabController = TabController(length: widget.child.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemBuilder: (BuildContext context, int index) =>
              widget.child[index % widget.child.length],
          onPageChanged: onPageChanged,
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: IgnorePointer(
              child: TabBar(
                isScrollable: true,
                indicator: const BoxDecoration(),
                labelPadding: const EdgeInsets.symmetric(
                  horizontal: 2,
                ),
                unselectedLabelColor: Theme.of(context)
                    .colorScheme
                    .inversePrimary
                    .withOpacity(.7),
                controller: tabController,
                tabs: List<Widget>.generate(
                  widget.child.length,
                  (int index) => const Text(
                    "●",
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void onPageChanged(int index) {
    tabController.animateTo(index % widget.child.length);
  }
}
