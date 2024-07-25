import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class UiWaterfall<T> extends StatefulWidget {
  final double? spacing;
  final double width;
  final List<UiWaterfallItem<T>> data;
  final Widget Function(T? data) itemBuilder;

  const UiWaterfall({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.spacing,
    required this.width,
  });

  @override
  State<UiWaterfall<T>> createState() => _UiWaterfallState<T>();
}

class _UiWaterfallState<T> extends State<UiWaterfall<T>> {
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
    List<UiWaterfallItem<T>> leftData = [];
    List<UiWaterfallItem<T>> rightData = [];

    for (UiWaterfallItem<T> item in widget.data) {
      double height = item.height;
      if (rightHeight > leftHeight) {
        leftData.add(item);
        leftHeight += height;
      } else {
        rightData.add(item);
        rightHeight += height;
      }
    }

    if (rightData.isNotEmpty) {
      rightHeight += (rightData.length - 1) * spacing;
    }

    if (leftData.isNotEmpty) {
      leftHeight += (leftData.length - 1) * spacing;
    }

    if (rightHeight > leftHeight) {
      double emptyHeight = rightHeight - leftHeight;
      leftData.add(UiWaterfallItem(height: emptyHeight));
    } else if (rightHeight < leftHeight) {
      double emptyHeight = leftHeight - rightHeight;
      rightData.add(UiWaterfallItem(height: emptyHeight));
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
    required List<UiWaterfallItem<T>> listData,
  }) =>
      ListView.separated(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          UiWaterfallItem<T> item = listData[index];
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

class UiWaterfallItem<T> {
  double height;
  T? data;

  UiWaterfallItem({
    required this.height,
    this.data,
  });
}
