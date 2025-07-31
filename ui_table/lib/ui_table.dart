import 'dart:math';

import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class UiTable extends StatefulWidget {
  final List<double> cellsWidth;
  final UiTableItem head;
  final List<UiTableItem> data;
  final double headerHeight;
  final Color? headColor;
  final double cellHeight;
  final Color? borderColor;
  final Color? evenColor;
  final Color? oddColor;

  const UiTable({
    super.key,
    required this.cellsWidth,
    required this.head,
    required this.data,
    this.borderColor,
    this.headColor,
    this.headerHeight = 40,
    this.evenColor,
    this.oddColor,
    this.cellHeight = 40,
  });

  @override
  State<UiTable> createState() => _UiTableState();
}

class _UiTableState extends State<UiTable> {
  final double track = 10;
  late final double leftFix;
  late final double rightFix;
  late final BorderSide borderSide;

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

  late double headerHeight;
  late double cellHeight;

  @override
  void initState() {
    super.initState();

    headerHeight = widget.headerHeight.roundToDouble();
    cellHeight = widget.cellHeight.roundToDouble();

    for (int i = 0; i < widget.cellsWidth.length; i++) {
      widget.cellsWidth[i] = widget.cellsWidth[i].roundToDouble();
    }

    leftFix = widget.cellsWidth.first;
    rightFix = widget.cellsWidth.last + track;

    borderSide = BorderSide(color: widget.borderColor ?? Colors.grey);

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
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      removeRight: true,
      removeLeft: true,
      removeBottom: true,
      child: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(scrollbars: false),
        child: KeyboardListener(
          autofocus: true,
          onKeyEvent: _handleKeyEvent,
          focusNode: FocusNode(),
          child: Column(
            children: [
              Row(
                children: [
                  _buildHeaderLeft(),
                  Expanded(child: _buildHeaderCenter()),
                  _buildHeaderRight(),
                  SizedBox(width: track),
                ],
              ),
              Expanded(
                child: Row(
                  children: [
                    _buildBodyLeft(),
                    Expanded(child: _buildBodyCenter()),
                    _buildBodyRight(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color? indexColor(int index) =>
      index.isEven ? widget.evenColor : widget.oddColor;

  //body ====
  Column _buildBodyCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            controller: scrollHorizontalCenter,
            child: SizedBox(
              width: widget.cellsWidth.sublist(1, widget.cellsWidth.length - 1).reduce((a, b) => a + b),
              child: ListView.builder(
                controller: scrollVerticalCenter,
                itemCount: widget.data.length - 2,
                itemBuilder: (BuildContext context, int index) {
                  final item = widget.data[index];
                  return Container(
                    key: ValueKey("body-center-${item.key}"),
                    height: cellHeight,
                    decoration: BoxDecoration(
                      color: indexColor(index),
                      border: index == 0 ? null : Border(top: borderSide),
                    ),
                    child: Row(
                      children: item.row
                          .sublist(1, item.row.length - 1)
                          .asMap()
                          .entries
                          .map(
                            (MapEntry<int, Widget> e) => Container(
                              alignment: Alignment.center,
                              height: double.infinity,
                              width: widget.cellsWidth[e.key + 1],
                              decoration: e.key == 0
                                  ? null
                                  : BoxDecoration(
                                      border: Border(left: borderSide),
                                    ),
                              child: e.value,
                            ),
                          )
                          .toList(),
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
            thumbVisibility: true,
            controller: scrollHorizontalBar,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: scrollHorizontalBar,
              itemCount: widget.cellsWidth.length - 2,
              itemBuilder: (BuildContext context, int index) =>
                  SizedBox(width: widget.cellsWidth[index + 1]),
            ),
          ),
        ),
      ],
    );
  }

  SizedBox _buildBodyRight() {
    return SizedBox(
      width: rightFix,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollVerticalRightFix,
                    itemCount: widget.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final item = widget.data[index];
                      return Container(
                        key: ValueKey("body-right-${item.key}"),
                        alignment: Alignment.center,
                        height: cellHeight,
                        decoration: BoxDecoration(
                          color: indexColor(index),
                          border: Border(
                            top: index == 0 ? BorderSide.none : borderSide,
                            left: borderSide,
                          ),
                        ),
                        child: item.row.last,
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: track,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: scrollVerticalBar,
                    child: ListView.builder(
                      controller: scrollVerticalBar,
                      itemCount: widget.data.length,
                      itemBuilder: (BuildContext context, int index) =>
                          SizedBox(height: cellHeight),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: track),
        ],
      ),
    );
  }

  SizedBox _buildBodyLeft() {
    return SizedBox(
      width: leftFix,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollVerticalLeftFix,
              itemCount: widget.data.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.data[index];
                return Container(
                  key: ValueKey("body-left-${item.key}"),
                  height: cellHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: indexColor(index),
                    border: Border(
                      top: index == 0 ? BorderSide.none : borderSide,
                      right: borderSide,
                    ),
                  ),
                  child: item.row.first,
                );
              },
            ),
          ),
          SizedBox(height: track),
        ],
      ),
    );
  }

  //head ===
  Container _buildHeaderRight() {
    return Container(
      width: rightFix - track,
      height: headerHeight,
      decoration: BoxDecoration(
        color: widget.headColor,
        border: Border(left: borderSide, bottom: borderSide),
      ),
      alignment: Alignment.center,
      child: widget.head.row.last,
    );
  }

  Container _buildHeaderCenter() {
    return Container(
      height: headerHeight,
      color: widget.headColor,
      child: ListView.builder(
        controller: scrollHorizontalLeftFix,
        scrollDirection: Axis.horizontal,
        itemCount: widget.head.row.length - 2,
        itemBuilder: (BuildContext context, int index) => Container(
          width: widget.cellsWidth[index + 1],
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              left: index == 0 ? BorderSide.none : borderSide,
              bottom: borderSide,
            ),
          ),
          child: widget.head.row[index + 1],
        ),
      ),
    );
  }

  Container _buildHeaderLeft() {
    return Container(
      width: leftFix,
      height: headerHeight,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: widget.headColor,
        border: Border(right: borderSide, bottom: borderSide),
      ),
      child: widget.head.row.first,
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

  void _handleKeyEvent(KeyEvent event) {
    switch (event.logicalKey.keyLabel) {
      case 'Arrow Right':
        _horizontalControllers.jumpTo(_horizontalControllers.offset + 10);
        break;
      case 'Arrow Left':
        _horizontalControllers.jumpTo(
          max(0, _horizontalControllers.offset - 10),
        );
        break;
      case 'Arrow Up':
        _verticalControllers.jumpTo(max(0, _verticalControllers.offset + 10));
        break;
      case 'Arrow Down':
        _verticalControllers.jumpTo(max(0, _verticalControllers.offset - 10));
        break;
    }
  }
}

class UiTableItem {
  final String? key;
  final List<Widget> row;

  UiTableItem({this.key, required this.row});
}
