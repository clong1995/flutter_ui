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
  int index = 0;

  @override
  Widget build(BuildContext context) => Container(
    height: widget.height,
    decoration: widget.decoration,
    padding: widget.padding,
    child: Row(
      children:
          widget.items
              .asMap()
              .entries
              .map(
                (e) =>
                    e.value.isSpacer == true
                        ? e.value.item
                        : Expanded(
                          child: InkWell(
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

  UiPageViewBottomBarItem({
    required this.item,
    this.selectedItem,
    this.onTap,
    this.isSpacer,
  });
}
