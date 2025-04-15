import 'package:flutter/material.dart';

class UiPageViewBottomBar extends StatefulWidget {
  final double height;
  final Decoration? decoration;
  final List<UiPageViewBottomBarItem> items;
  final EdgeInsetsGeometry? padding;

  const UiPageViewBottomBar({
    super.key,
    required this.height,
    required this.decoration,
    required this.items,
    this.padding,
  });

  @override
  State<UiPageViewBottomBar> createState() => _UiPageViewBottomBarState();
}

class _UiPageViewBottomBarState extends State<UiPageViewBottomBar> {
  var currIndex = 0;
  List<UiPageViewBottomBarItem> items = [];

  @override
  void initState() {
    var index = -1;
    for (var i = 0; i < widget.items.length; i++) {
      if (widget.items[i].isSpacer != true) {
        index++;
      }
      widget.items[i].index = index;
    }
    super.initState();
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
                            onTap:
                                e.onTap == null
                                    ? null
                                    : () {
                                      currIndex = e.index;
                                      setState(() {});
                                      e.onTap!(e.index);
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
}

class UiPageViewBottomBarItem {
  final bool? isSpacer;
  final Widget item;
  final Widget? selectedItem;
  final void Function(int)? onTap;
  int index = 0;

  UiPageViewBottomBarItem({
    required this.item,
    this.selectedItem,
    this.onTap,
    this.isSpacer,
  });
}
