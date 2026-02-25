
import 'package:flutter/material.dart' show MenuAnchor, MenuItemButton, MenuStyle;
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rpx/ext.dart';

class UiDropMenu<T> extends StatefulWidget {
  const UiDropMenu({
    required this.items,
    super.key,
    this.value,
    this.width,
    this.height,
    this.onChanged,
  }) /*: assert(
         !(value == null || !items.containsKey(value)),
         'the provided value: $value is not in items',
       )*/;

  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?>? onChanged;
  final double? width;
  final double? height;

  @override
  State<UiDropMenu<T>> createState() => _UiDropMenuState<T>();
}

class _UiDropMenuState<T> extends State<UiDropMenu<T>> {
  T? value;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  @override
  void didUpdateWidget(UiDropMenu<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
      ),
      builder:
          (context, controller, child) {
            return GestureDetector(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: Container(
                height: widget.height ?? 28.r,
                padding: EdgeInsets.only(
                  left: 10.r,
                  top: 5.r,
                  right: 5.r,
                  bottom: 5.r,
                ),
                width: widget.width,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x42000000)),
                  borderRadius: BorderRadius.circular(5.r),
                  color: const Color(0xFFFFFFFF),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          value == null ? '未选择' : widget.items[value] ?? '无选项',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(height: 1.r),
                        ),
                      ),
                    ),
                    FaIcon(
                      FontAwesomeIcons.caretDown,
                      color: const Color(0xDD000000),
                      size: 20.r,
                    ),
                  ],
                ),
              ),
            );
          },
      menuChildren: widget.items.entries
          .map(
            (e) => SizedBox(
              width: widget.width,
              height: widget.height ?? 28.r,
              child: MenuItemButton(
                style: MenuItemButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  if (e.key == value) {
                    return;
                  }
                  setState(() {
                    value = e.key;
                  });
                  widget.onChanged?.call(value);
                },
                child: Center(child: Text(e.value)),
              ),
            ),
          )
          .toList(),
    );
  }
}
