import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class Waterfall<T> extends StatefulWidget {
  final double? spacing;
  final double width;
  final List<WaterfallItem<T>> data;
  final Widget Function(T? data) itemBuilder;

  const Waterfall({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.spacing,
    required this.width,
  });

  @override
  State<Waterfall<T>> createState() => _WaterfallState<T>();
}

class _WaterfallState<T> extends State<Waterfall<T>> {
  late double width;
  late double spacing;
  late ScrollController leftScrollController;
  late ScrollController rightScrollController;

  @override
  void initState() {
    super.initState();
    spacing = widget.spacing ?? 5;
    width = (widget.width - (spacing * 3)) / 2;
    LinkedScrollControllerGroup linkedScrollControllerGroup =
    LinkedScrollControllerGroup();
    leftScrollController = linkedScrollControllerGroup.addAndGet();
    rightScrollController = linkedScrollControllerGroup.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    double leftHeight = 0;
    double rightHeight = 0;
    List<WaterfallItem<T>> leftData = [];
    List<WaterfallItem<T>> rightData = [];

    for (WaterfallItem<T> item in widget.data) {
      double height = item.height;
      if (rightHeight > leftHeight) {
        leftData.add(item);
        leftHeight += height;
      } else {
        rightData.add(item);
        rightHeight += height;
      }
    }

    if (rightHeight > leftHeight) {
      double emptyHeight = rightHeight - leftHeight;
      leftData.add(WaterfallItem(height: emptyHeight));
    } else if (rightHeight < leftHeight) {
      double emptyHeight = leftHeight - rightHeight;
      rightData.add(WaterfallItem(height: emptyHeight));
    }

    return Row(
      children: [
        SizedBox(width: spacing),
        SizedBox(
          width: width,
          child: listView(
            controller: leftScrollController,
            listData: leftData,
          ),
        ),
        SizedBox(width: spacing),
        SizedBox(
          width: width,
          child: listView(
            controller: rightScrollController,
            listData: rightData,
          ),
        ),
        SizedBox(width: spacing),
      ],
    );
  }

  ListView listView({
    required ScrollController controller,
    required List<WaterfallItem<T>> listData,
  }) =>
      ListView.separated(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          WaterfallItem<T> item = listData[index];
          return SizedBox(
            height: item.height,
            child: widget.itemBuilder(item.data),
          );
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: spacing),
        itemCount: listData.length,
      );
}

class WaterfallItem<T> {
  double height;
  T? data;

  WaterfallItem({
    required this.height,
    this.data,
  });
}
