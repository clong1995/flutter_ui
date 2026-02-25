
import 'package:flutter/material.dart' show PopupMenuItem, showMenu;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';

class UiPopMenu<T> extends StatelessWidget {
  const UiPopMenu({
    required this.child,
    required this.items,
    super.key,
    this.onTap,
  });

  final Widget child;
  final Map<T, Widget> items;
  final void Function(T?)? onTap;

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();
    return GestureDetector(
      key: key,
      onTap: onTap == null
          ? null
          : () async {
              final result = await _showPopupMenu<T>(
                key: key,
                context: context,
                items: items,
              );
              onTap!(result);
            },
      child: child,
    );
  }
}

Future<T?> _showPopupMenu<T>({
  required GlobalKey key,
  required BuildContext context,
  required Map<T, Widget> items,
}) async {
  final renderBox = key.currentContext!.findRenderObject()! as RenderBox;
  final offset = renderBox.localToGlobal(Offset.zero);
  double height = 35.r;
  final result = await showMenu<T>(
    context: context,
    color: const Color(0xFFFFFFFF),
    menuPadding: EdgeInsets.zero,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height + 5.r,
      offset.dx + renderBox.size.width,
      offset.dy + height * items.length,
    ),
    items: items.entries
        .map(
          (e) => PopupMenuItem<T>(
            height: height,
            padding: EdgeInsets.zero,
            value: e.key,
            child: e.value,
          ),
        )
        .toList(),
  );

  return result;
}
