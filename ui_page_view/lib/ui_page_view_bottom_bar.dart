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
  int currIndex = 0;

  @override
  Widget build(BuildContext context) => Container(
    height: widget.height,
    decoration: widget.decoration,
    padding: widget.padding,
    child: Row(
      children:
          widget.items.asMap().entries.map((e) {
            var index = e.key;
            final value = e.value;
            if (e.value.isSpacer == true) {
              index--;
            }
            return value.isSpacer == true
                ? value.item
                : Expanded(
                  child: InkWell(
                    onTap:
                        value.onTap == null
                            ? null
                            : () {
                              currIndex = index;
                              setState(() {});
                              value.onTap!(index);
                            },
                    child:
                        currIndex == index
                            ? value.selectedItem ?? value.item
                            : value.item,
                  ),
                );
          }).toList(),
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
