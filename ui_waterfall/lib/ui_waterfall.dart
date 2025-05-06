import 'package:flutter/cupertino.dart';

class UiWaterfall<T> extends StatefulWidget {
  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final List<UiWaterfallItem<T>> data;

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

class _UiWaterfallState<T>
    extends State<UiWaterfall<T>> {
  List<SizedBox> virtualColumn = [];
  List<_ChildCol<T>> fallColumns = [];

  @override
  void initState() {
    super.initState();
    //实际列
    fallColumns = List.generate(widget.crossAxisCount, (_) => _ChildCol<T>());
    //虚拟列
    virtualWidget(widget.data);
  }

  @override
  void didUpdateWidget(covariant UiWaterfall<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.crossAxisCount != widget.crossAxisCount ||
        oldWidget.mainAxisSpacing != widget.mainAxisSpacing ||
        oldWidget.crossAxisSpacing != widget.crossAxisSpacing ||
        oldWidget.itemBuilder != widget.itemBuilder ||
        oldWidget.data != widget.data) {
      if (oldWidget.crossAxisCount != widget.crossAxisCount) {
        //全量
        //列数量变话
        //需要清空所有数据重新布局，计算压力很大
        fallColumns = List.generate(
          widget.crossAxisCount,
              (_) => _ChildCol<T>(),
        );
        //虚拟列
        virtualWidget(widget.data);
      } else {
        //增量

        //在旧的(oldWidget)中但不在新的(widget)中的元素
        //减少的
        final reduce = diff(oldWidget.data, widget.data);
        //删除减少的
        for (var cols in fallColumns) {
          final ids = reduce.map((e) => e.id).toList();
          removeItems(cols.list, ids);
        }

        //在新的(widget)中但不在旧的(oldWidget)中的元素
        //增加的
        final increase = diff(widget.data, oldWidget.data);
        //增加增加的
        virtualWidget(increase);
      }
      setState(() {});
    }
  }

  void removeItems(List<_Child> list, List<String> keys) {
    final idsSet = keys.toSet();
    list.removeWhere((item) => idsSet.contains(item.data.id));
  }

  //在 list1 但不在 list2 的元素
  List<UiWaterfallItem<T>> diff(List<UiWaterfallItem<T>> list1, List<UiWaterfallItem<T>> list2) {
    return list1
        .where((item1) => list2.any((item2) => item2.id == item1.id))
        .toList();
  }

  //生成虚拟列
  void virtualWidget(List<UiWaterfallItem<T>> data) {
    List<GlobalKey> virtualKeys = List.generate(
      data.length,
          (_) => GlobalKey(),
    );
    virtualColumn =
        data.indexed
            .map(
              (e) => SizedBox(
            key: virtualKeys[e.$1],
            child: widget.itemBuilder(e.$2.data),
          ),
        )
            .toList();

    //计算尺寸
    WidgetsBinding.instance.addPostFrameCallback((_) {
      for (int i = 0; i < virtualKeys.length; i++) {
        final key = virtualKeys[i];
        final RenderBox? box =
        key.currentContext?.findRenderObject() as RenderBox?;

        final size = box?.size ?? Size.zero;

        final shortCol = colIndex(fallColumns);
        //这里可能需要去重
        shortCol.list.add(
          _Child()
            ..data = data[i].data
            ..size = size,
        );
      }
      //释放布局资源
      virtualColumn = [];
      virtualKeys.clear();
      setState(() {});
    });
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
                  key: ValueKey("${widget.crossAxisCount}-$col"),
                  delegate: SliverChildBuilderDelegate(
                        (context, row) => Padding(
                      key: ValueKey(column[row].data),
                      padding: EdgeInsets.only(bottom: widget.crossAxisSpacing),
                      child: widget.itemBuilder(column[row].data),
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

class UiWaterfallItem<T> {
  String id = "";
  late T data;
}


class _Child<UiWaterfallItem> {
  Size size = Size.zero;
  late UiWaterfallItem data;
}

class _ChildCol<UiWaterfallItem> {
  double get height =>
      list.map((e) => e.size.height).fold(0, (prev, current) => prev + current);
  final List<_Child<UiWaterfallItem>> list = [];
}
