import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class UiTable extends StatefulWidget {
  final List<double> cellsWidth;
  final double headerHeight;
  final double cellHeight;
  final List<List<Widget>> data;

  const UiTable({
    super.key,
    required this.cellsWidth,
    required this.data,
    this.headerHeight = 40,
    this.cellHeight = 40,
  });

  @override
  State<UiTable> createState() => _UiTableState();
}

class _UiTableState extends State<UiTable> {
  final BorderSide borderSize = const BorderSide(color: Colors.grey);
  final double track = 10;
  late final double leftFix;
  late final double rightFix;

  late ScrollController scrollVerticalLeftFix;
  late ScrollController scrollVerticalRightFix;
  late ScrollController scrollVerticalCenter;
  late ScrollController scrollVerticalBar;

  late ScrollController scrollHorizontalLeftFix;
  late ScrollController scrollHorizontalCenter;
  late ScrollController scrollHorizontalBar;

  final LinkedScrollControllerGroup _verticalControllers =
      LinkedScrollControllerGroup();

  final LinkedScrollControllerGroup _horizontalControllers =
      LinkedScrollControllerGroup();

  @override
  void initState() {
    super.initState();
    leftFix = widget.cellsWidth.first;
    rightFix = widget.cellsWidth.last + track;

    scrollVerticalLeftFix = _verticalControllers.addAndGet();
    scrollVerticalRightFix = _verticalControllers.addAndGet();
    scrollVerticalCenter = _verticalControllers.addAndGet();
    scrollVerticalBar = _verticalControllers.addAndGet();

    scrollHorizontalLeftFix = _horizontalControllers.addAndGet();
    scrollHorizontalCenter = _horizontalControllers.addAndGet();
    scrollHorizontalBar = _horizontalControllers.addAndGet();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        children: [
          Container(
            height: widget.headerHeight,
            decoration: BoxDecoration(
              border: Border(
                bottom: borderSize,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: leftFix,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      right: borderSize,
                    ),
                  ),
                  child: widget.data.first.first,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollHorizontalLeftFix,
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.data.first.length - 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: widget.cellsWidth[index + 1],
                        decoration: BoxDecoration(
                          border: index == 0
                              ? null
                              : Border(
                                  left: borderSize,
                                ),
                        ),
                        child: widget.data.first[index + 1],
                      );
                    },
                  ),
                ),
                Container(
                  width: rightFix - track,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      left: borderSize,
                    ),
                  ),
                  child: widget.data.first.last,
                ),
                SizedBox(width: track),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Container(
                  width: leftFix,
                  decoration: BoxDecoration(
                    border: Border(right: borderSize),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: scrollVerticalLeftFix,
                          itemCount: widget.data.length - 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: widget.cellHeight,
                              decoration: BoxDecoration(
                                border:
                                    index == 0 ? null : Border(top: borderSize),
                              ),
                              child: widget.data[index + 1].first,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: track),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          controller: scrollHorizontalCenter,
                          child: SizedBox(
                            width: widget.cellsWidth
                                .sublist(1, widget.cellsWidth.length - 1)
                                .reduce((a, b) => a + b),
                            child: ListView.builder(
                              controller: scrollVerticalCenter,
                              itemCount: widget.data.length - 1,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: widget.cellHeight,
                                  decoration: BoxDecoration(
                                    border: index == 0
                                        ? null
                                        : Border(
                                            top: borderSize,
                                          ),
                                  ),
                                  child: Row(
                                    children: widget.data[index + 1]
                                        .sublist(1,
                                            widget.data[index + 1].length - 1)
                                        .asMap()
                                        .entries
                                        .map((e) {
                                      return Container(
                                        height: double.infinity,
                                        width: widget.cellsWidth[e.key + 1],
                                        decoration: BoxDecoration(
                                          border: e.key == 0
                                              ? null
                                              : Border(
                                                  left: borderSize,
                                                ),
                                        ),
                                        child: e.value,
                                      );
                                    }).toList(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: track,
                        child: Scrollbar(
                          controller: scrollHorizontalBar,
                          thumbVisibility: true,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: scrollHorizontalBar,
                            child: Container(
                              color: Colors.orange,
                              height: double.infinity,
                              width: widget.cellsWidth
                                  .sublist(1, widget.cellsWidth.length - 1)
                                  .reduce((a, b) => a + b),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: rightFix,
                  decoration: BoxDecoration(
                    border: Border(left: borderSize),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            //内容右边
                            Expanded(
                              child: ListView.builder(
                                controller: scrollVerticalRightFix,
                                itemCount: widget.data.length - 1,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: widget.cellHeight,
                                    decoration: BoxDecoration(
                                      border: index == 0
                                          ? null
                                          : Border(
                                              top: borderSize,
                                            ),
                                    ),
                                    child: widget.data[index + 1].last,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: track,
                              height: (widget.data.length - 1) * widget.cellHeight,
                              child: Scrollbar(
                                controller: scrollVerticalBar,
                                thumbVisibility: true,
                                child: SingleChildScrollView(
                                  controller: scrollVerticalBar,
                                  child: Container(
                                    color: Colors.green,
                                    width: double.infinity,
                                    height: 100,
                                    //height: (widget.data.length - 1) * widget.cellHeight,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: track),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollVerticalLeftFix.dispose();
    scrollVerticalRightFix.dispose();
    scrollVerticalCenter.dispose();
    scrollVerticalBar.dispose();
    scrollHorizontalLeftFix.dispose();
    scrollHorizontalCenter.dispose();
    scrollHorizontalBar.dispose();
    super.dispose();
  }
}
