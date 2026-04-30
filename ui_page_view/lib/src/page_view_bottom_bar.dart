import 'package:flutter/widgets.dart';

class UiPageViewBottomBar extends StatefulWidget {
  const UiPageViewBottomBar({
    required this.height,
    required this.items,
    required this.controller,
    super.key,
    this.decoration,
    this.padding,
    this.mainAxisAlignment,
  });

  final double height;
  final Decoration? decoration;
  final List<UiPageViewBottomBarItem> items;
  final PageController controller;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  State<UiPageViewBottomBar> createState() => _UiPageViewBottomBarState();
}

class _UiPageViewBottomBarState extends State<UiPageViewBottomBar> {
  int currIndex = 0;
  final List<UiPageViewBottomBarItem> items = [];

  @override
  void initState() {
    super.initState();
    indexItem();
  }

  @override
  void didUpdateWidget(covariant UiPageViewBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    indexItem();
  }

  @override
  Widget build(BuildContext context) => Container(
    height: widget.height,
    decoration: widget.decoration,
    padding: widget.padding,
    child: Row(
      mainAxisAlignment: widget.mainAxisAlignment ?? MainAxisAlignment.start,
      children: widget.items.map(
        (e) {
          final item = e.itemBuilder(false);
          final selectedItem = e.itemBuilder(true);

          final detectorItem = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (currIndex == e.index) {
                return;
              }
              currIndex = e.index;
              setState(() {});
              widget.controller.jumpToPage(e.index);
            },
            child: currIndex == e.index ? selectedItem : item,
          );

          return e.isSpacer
              ? item
              : widget.mainAxisAlignment == null
              ? Expanded(
                  child: detectorItem,
                )
              : detectorItem;
        },
      ).toList(),
    ),
  );

  void indexItem() {
    var index = -1;
    for (var i = 0; i < widget.items.length; i++) {
      if (!widget.items[i].isSpacer) {
        index++;
        widget.items[i].index = index;
      }
    }
  }
}

class UiPageViewBottomBarItem {
  UiPageViewBottomBarItem({
    required this.itemBuilder,
    this.isSpacer = false,
  });

  final bool isSpacer;

  //
  // ignore:avoid_positional_boolean_parameters
  final Widget Function(bool) itemBuilder;

  @protected
  int index = 0;
}
