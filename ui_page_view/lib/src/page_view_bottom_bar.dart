
import 'package:flutter/widgets.dart';

class UiPageViewBottomBar extends StatefulWidget {
  const UiPageViewBottomBar({
    required this.height,
    required this.items,
    required this.controller,
    super.key,
    this.decoration,
    this.padding,
  });

  final double height;
  final Decoration? decoration;
  final List<UiPageViewBottomBarItem> items;
  final PageController controller;
  final EdgeInsetsGeometry? padding;

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
      children: widget.items
          .map(
            (e) => e.isSpacer
                ? e.item
                : Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (currIndex == e.index) {
                          return;
                        }
                        currIndex = e.index;
                        setState(() {});
                        widget.controller.jumpToPage(e.index);
                      },
                      child: currIndex == e.index
                          ? e.selectedItem ?? e.item
                          : e.item,
                    ),
                  ),
          )
          .toList(),
    ),
  );

  void indexItem() {
    var index = -1;
    for (var i = 0; i < widget.items.length; i++) {
      if (widget.items[i].isSpacer != true) {
        index++;
        widget.items[i].index = index;
      }
    }
  }
}

class UiPageViewBottomBarItem {
  UiPageViewBottomBarItem({
    required this.item,
    this.selectedItem,
    this.isSpacer = false,
  });

  final bool isSpacer;
  final Widget item;
  final Widget? selectedItem;
  int index = 0;
}
