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
  final BorderSide borderSize =
      const BorderSide(color: Colors.grey, width: 0.3);
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
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(
        scrollbars: false,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade200,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Row(
                children: [
                  _buildLeftFixPanel(),
                  Expanded(
                    child: _buildMovableContentPanel(),
                  ),
                  _buildRightFixPanel(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMovableContentPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                itemBuilder: (BuildContext context, int index) => Container(
                  height: widget.cellHeight,
                  decoration: index == 0
                      ? null
                      : BoxDecoration(
                          border: Border(
                            top: borderSize,
                          ),
                        ),
                  child: Row(
                    children: widget.data[index + 1]
                        .sublist(1, widget.data[index + 1].length - 1)
                        .asMap()
                        .entries
                        .map(
                          (MapEntry<int, Widget> e) => Container(
                            height: double.infinity,
                            width: widget.cellsWidth[e.key + 1],
                            decoration: e.key == 0
                                ? null
                                : BoxDecoration(
                                    border: Border(
                                      left: borderSize,
                                    ),
                                  ),
                            child: Align(
                              alignment: Alignment.center,
                              child: e.value,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: track,
          child: Scrollbar(
            thumbVisibility: true,
            controller: scrollHorizontalBar,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: scrollHorizontalBar,
              child: SizedBox(
                width: widget.cellsWidth
                    .sublist(1, widget.cellsWidth.length - 1)
                    .reduce((a, b) => a + b),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRightFixPanel() {
    return Container(
      width: rightFix,
      decoration: BoxDecoration(
        border: Border(
          left: borderSize.copyWith(
            width: .3,
            color: Colors.grey.shade300,
          ),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(-2, 0), // First right side shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(-3, 0), // Second right side shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(-3, 0), // Third right side shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollVerticalRightFix,
                    itemCount: widget.data.length - 1,
                    itemBuilder: (BuildContext context, int index) => Container(
                      height: widget.cellHeight,
                      decoration: index == 0
                          ? null
                          : BoxDecoration(
                              border: Border(top: borderSize),
                            ),
                      child: widget.data[index + 1].last,
                    ),
                  ),
                ),
                SizedBox(
                  width: track,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: scrollVerticalBar,
                    child: ListView.builder(
                      controller: scrollVerticalBar,
                      itemCount: widget.data.length - 1,
                      itemBuilder: (BuildContext context, int index) =>
                          SizedBox(
                        height: widget.cellHeight,
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
    );
  }

  Widget _buildLeftFixPanel() {
    return Container(
      width: leftFix,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(2, 0), // First right side shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(3, 0), // Second right side shadow
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(3, 0), // Third right side shadow
          ),
        ],
        border: Border(right: borderSize.copyWith(color: Colors.grey.shade300)),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollVerticalLeftFix,
              itemCount: widget.data.length - 1,
              itemBuilder: (BuildContext context, int index) => Container(
                height: widget.cellHeight,
                decoration: BoxDecoration(
                  border: index == 0 ? null : Border(top: borderSize),
                ),
                child: Align(
                    alignment: Alignment.center,
                    child: widget.data[index + 1].first),
              ),
            ),
          ),
          SizedBox(height: track),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: widget.headerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: borderSize.copyWith(width: .3, color: Colors.grey.shade300),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            spreadRadius: 5,
            blurRadius: 10,
            offset: const Offset(0, 3), // First shadow
          ),
          BoxShadow(
            color: Colors.blue.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, -3), // Second shadow
          ),
          BoxShadow(
            color: Colors.blue.withOpacity(0.04),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(-3, 3), // Third shadow
          ),
        ],
      ),
      child: DefaultTextStyle(
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        child: Row(
          children: [
            _buildLeftFixHeader(),
            Expanded(
              child: _buildMovableHeader(),
            ),
            _buildRightFixHeader(),
            SizedBox(width: track),
          ],
        ),
      ),
    );
  }

  Container _buildRightFixHeader() {
    return Container(
      width: rightFix - track,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: borderSize,
        ),
      ),
      child: Align(alignment: Alignment.center, child: widget.data.first.last),
    );
  }

  Widget _buildMovableHeader() {
    return ListView.builder(
      controller: scrollHorizontalLeftFix,
      scrollDirection: Axis.horizontal,
      itemCount: widget.data.first.length - 2,
      itemBuilder: (BuildContext context, int index) => Container(
        width: widget.cellsWidth[index + 1],
        decoration: BoxDecoration(
          color: Colors.white,
          border: index == 0
              ? null
              : Border(
                  left: borderSize,
                ),
        ),
        child: Align(
          alignment: Alignment.center,
          child: widget.data.first[index + 1],
        ),
      ),
    );
  }

  Widget _buildLeftFixHeader() {
    return Container(
      width: leftFix,
      height: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          right: borderSize,
        ),
      ),
      child: Align(
        alignment: Alignment.center,
        child: widget.data.first.first,
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
