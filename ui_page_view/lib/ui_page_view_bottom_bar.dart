import 'package:flutter/material.dart';

class UiPageViewBottomBar extends StatefulWidget {
  final double height;
  final Decoration? decoration;
  final List<UiPageViewBottomBarItem> items;

  const UiPageViewBottomBar({
    super.key,
    required this.height,
    required this.decoration,
    required this.items,
  });

  @override
  State<UiPageViewBottomBar> createState() => _UiPageViewBottomBarState();
}

class _UiPageViewBottomBarState extends State<UiPageViewBottomBar> {
  int index = 0;

  @override
  Widget build(BuildContext context) => Container(
    height: widget.height,
    decoration: widget.decoration,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          widget.items
              .asMap()
              .entries
              .map(
                (e) =>
                    e.value.isSpacer == true
                        ? e.value.item
                        : InkWell(
                          onTap:
                              e.value.onTap == null
                                  ? null
                                  : () {
                                    index = e.key;
                                    setState(() {});
                                    e.value.onTap!(index);
                                  },
                          child:
                              index == e.key
                                  ? e.value.selectedItem ?? e.value.item
                                  : e.value.item,
                        ),
              )
              .toList(),
    ),
  );
}

class UiPageViewBottomBarItem {
  final bool? isSpacer; //用于做特殊的间隔，点击不会有任何效果，建议是空白组件
  final Widget item;
  final Widget? selectedItem;
  final void Function(int)? onTap;

  UiPageViewBottomBarItem({
    required this.item,
    this.selectedItem,
    this.onTap,
    this.isSpacer,
  });
}
