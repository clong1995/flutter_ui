import 'package:flutter/material.dart';

class UiPageViewBottomBar extends StatefulWidget {
  final double height;
  final Decoration? decoration;
  final List<UiPageViewBottomBarItem> items;
  final PageController controller;
  final EdgeInsetsGeometry? padding;

  const UiPageViewBottomBar({
    super.key,
    required this.height,
    required this.decoration,
    required this.items,
    this.padding,
    required this.controller,
  });

  @override
  State<UiPageViewBottomBar> createState() => _UiPageViewBottomBarState();
}

class _UiPageViewBottomBarState extends State<UiPageViewBottomBar> {
  var currIndex = 0;
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
      children:
          widget.items
              .map(
                (e) =>
                    e.isSpacer == true
                        ? e.item
                        : Expanded(
                          child: InkWell(
                            onTap: () {
                              if (currIndex == e.index) {
                                return;
                              }
                              currIndex = e.index;
                              setState(() {});
                              widget.controller.jumpToPage(e.index);
                            },
                            child:
                                currIndex == e.index
                                    ? e.selectedItem ?? e.item
                                    : e.item,
                          ),
                        ),
              )
              .toList(),
    ),
  );

  void indexItem(){
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
  final bool? isSpacer;
  final Widget item;
  final Widget? selectedItem;
  int index = 0;

  UiPageViewBottomBarItem({
    required this.item,
    this.selectedItem,
    this.isSpacer,
  });
}
