import 'package:flutter/material.dart';

class UiWaterfall<T> extends StatefulWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<T> data;
  final Widget Function(T data) itemBuilder;

  const UiWaterfall({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
  });

  @override
  State<UiWaterfall<T>> createState() => _UiWaterfallState<T>();
}

class _UiWaterfallState<T> extends State<UiWaterfall<T>> {
  late final List<GlobalKey> childKeys;

  @override
  void initState() {
    super.initState();
    childKeys = List.generate(widget.data.length, (_) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < childKeys.length; i++) {
        final RenderBox? box = childKeys[i].currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final Size size = box.size;
          debugPrint("Item $i size: ${size.width} x ${size.height}");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double width = constraints.maxWidth;
              double height = constraints.maxHeight;
              double virtualHeight =
                  (width / widget.crossAxisCount) -
                  ((widget.crossAxisCount - 1) * widget.mainAxisSpacing) / 2;
              return Container(
                color: Colors.red,
                width: virtualHeight,
                child: ListView(
                  children:
                      widget.data.indexed
                          .map(
                            (e) => SizedBox(
                              key: childKeys[e.$1],
                              child: widget.itemBuilder(e.$2),
                            ),
                          )
                          .toList(),
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(child: Container(color: Colors.green.withAlpha(100))),
            SizedBox(width: widget.mainAxisSpacing),
            Expanded(child: Container(color: Colors.green.withAlpha(100))),
          ],
        ),
      ],
    );
  }
}
