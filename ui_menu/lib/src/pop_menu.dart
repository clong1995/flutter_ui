import 'package:flutter/material.dart';

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
    return InkWell(
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
  const double height = 35;
  final result = await showMenu<T>(
    context: context,
    color: Colors.white,
    menuPadding: EdgeInsets.zero,
    position: RelativeRect.fromLTRB(
      offset.dx,
      offset.dy + renderBox.size.height + 5,
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
