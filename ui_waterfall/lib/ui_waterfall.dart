import 'package:flutter/material.dart';

class UiWaterfall<T> extends StatefulWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<UiWaterfallItem<T>> data;
  final Widget Function(T? data) itemBuilder;

  const UiWaterfall({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    required this.mainAxisSpacing,
    required this.crossAxisSpacing,
  });

  @override
  State<UiWaterfall<T>> createState() => _UiWaterfallState<T>();
}

class _UiWaterfallState<T> extends State<UiWaterfall<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // constraints 提供父容器的约束信息
              return Text(
                '父容器大小: ${constraints.maxWidth} x ${constraints.maxHeight}',
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ),
      ],
    );
  }
}

class UiWaterfallItem<T> {
  double height;
  T? data;

  UiWaterfallItem({required this.height, this.data});
}
