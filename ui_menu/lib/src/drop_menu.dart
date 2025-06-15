import 'package:flutter/material.dart';

class UiDropMenu<T> extends StatefulWidget {
  final T? value;
  final Map<T, String> items;
  final ValueChanged<T?>? onChanged;
  final double? width;
  final double? height;

  UiDropMenu({
    super.key,
    this.value,
    required this.items,
    this.width,
    this.height,
    this.onChanged,
  }) : assert(
         !(value == null || !items.containsKey(value)),
         'the provided value: $value is not in items',
       );

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
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      style: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      builder:
          (BuildContext context, MenuController controller, Widget? child) {
            return GestureDetector(
              onTap: () {
                if (controller.isOpen) {
                  controller.close();
                } else {
                  controller.open();
                }
              },
              child: Container(
                height: widget.height ?? 30,
                padding: const EdgeInsets.only(left: 10, top: 5, right: 5, bottom: 5),
                width: widget.width,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0x42000000)),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          value == null ? "未选择" : widget.items[value]!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(height: 1),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black87,
                      size: 20,
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
              height: widget.height ?? 30,
              child: MenuItemButton(
                style: MenuItemButton.styleFrom(padding: EdgeInsets.zero),
                onPressed: () {
                  setState(() {
                    value = e.key;
                  });
                },
                child: Center(child: Text(e.value)),
              ),
            ),
          )
          .toList(),
    );
  }
}
