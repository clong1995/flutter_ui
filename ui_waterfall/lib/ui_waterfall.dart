import 'package:flutter/cupertino.dart';

class UiWaterfall<T extends UiWaterfallItem> extends StatefulWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<T> data;

  //如果有网络加载的图片
  //图片地址最好为 : https://www.abc.com/xxx_s_958x1280.png
  //其中 958 和 1280 是图片的尺寸，在builder的时候，算出比例使用 AspectRatio 提前设置图片尺寸和位置
  //达到实现高性能布局，防止因为图片加载而引起的多次全局重绘
  final Widget Function(T data) itemBuilder;

  const UiWaterfall({
    super.key,
    required this.data,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 5,
    this.crossAxisSpacing = 5,
  });

  @override
  State<UiWaterfall<T>> createState() => _UiWaterfallState<T>();
}

class _UiWaterfallState<T extends UiWaterfallItem>
    extends State<UiWaterfall<T>> {
  List<_Child> childKeys = [];
  List<SizedBox> virtualColumn = [];
  List<_ChildCol<T>> fallColumns = [];

  @override
  void initState() {
    super.initState();
    loadData();
    WidgetsBinding.instance.addPostFrameCallback(layout);
  }

  @override
  void didUpdateWidget(covariant UiWaterfall<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.crossAxisCount != widget.crossAxisCount ||
        oldWidget.mainAxisSpacing != widget.mainAxisSpacing ||
        oldWidget.crossAxisSpacing != widget.crossAxisSpacing ||
        oldWidget.itemBuilder != widget.itemBuilder ||
        oldWidget.data != widget.data) {
      loadData();
      WidgetsBinding.instance.addPostFrameCallback(layout);
      setState(() {});
    }
  }

  void loadData() {
    //
    fallColumns = List.generate(widget.crossAxisCount, (_) => _ChildCol<T>());
    //
    childKeys = List.generate(
      widget.data.length,
      (_) => _Child()..key = GlobalKey(),
    );
    virtualColumn =
        widget.data.indexed
            .map(
              (e) => SizedBox(
                key: childKeys[e.$1].key,
                child: widget.itemBuilder(e.$2),
              ),
            )
            .toList();
  }

  void layout(Duration duration) {
    for (int i = 0; i < childKeys.length; i++) {
      final _Child child = childKeys[i];
      final RenderBox? box =
          child.key.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        child.size = box.size;
      }

      //找到最小的那列
      final col = colIndex(fallColumns);
      col.height += child.size.height;
      col.list.add(widget.data[i]);
    }
    //释放布局资源
    virtualColumn = [];
    childKeys.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      //计算布局的尺寸
      Positioned(
        child: LayoutBuilder(
          builder:
              (context, constraints) => SizedBox(
                width:
                    (constraints.maxWidth / widget.crossAxisCount) -
                    ((widget.crossAxisCount - 1) * widget.mainAxisSpacing) / 2,
                child: SingleChildScrollView(
                  child: Column(children: virtualColumn),
                ),
              ),
        ),
      ),
      CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        slivers: [
          CupertinoSliverRefreshControl(onRefresh: () async {}),
          // SliverCrossAxisGroup(slivers: slivers)
          SliverCrossAxisGroup(
            slivers: List.generate(widget.crossAxisCount * 2 - 1, (col) {
              if (col.isOdd) {
                //奇数
                return SliverConstrainedCrossAxis(
                  maxExtent: widget.mainAxisSpacing,
                  sliver: const SliverToBoxAdapter(child: SizedBox.shrink()),
                );
              } else {
                final column = fallColumns[(col / 2).toInt()].list;
                return SliverList(
                  // key: ValueKey("${widget.crossAxisCount}-$col"),
                  delegate: SliverChildBuilderDelegate(
                    (context, row) => Padding(
                      key: ValueKey(column[row].key),
                      padding: EdgeInsets.only(bottom: widget.crossAxisSpacing),
                      child: widget.itemBuilder(column[row]),
                    ),
                    childCount: column.length,
                  ),
                );
              }
            }),
          ),
        ],
      ),
    ],
  );

  _ChildCol<T> colIndex(List<_ChildCol<T>> childCols) {
    int minIndex = 0;
    for (int i = 1; i < childCols.length; i++) {
      if (childCols[i].height < childCols[minIndex].height) {
        minIndex = i;
      }
    }
    return childCols[minIndex];
  }
}

class UiWaterfallItem {
  dynamic key;

  UiWaterfallItem(this.key);
}

class _Child {
  Size size = Size.zero;
  late GlobalKey key;
}

class _ChildCol<T> {
  double height = 0;
  final List<T> list = [];
}
