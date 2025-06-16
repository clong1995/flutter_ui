import 'package:flutter/material.dart';

class UiTree<T> extends StatefulWidget {
  final double indent;
  final List<UiTreeItem<T>> data;
  final Widget Function(
    BuildContext context,
    T data,
    int length,
    int level,
    bool expand,
    bool selected,
  )
  itemBuilder;

  final void Function(String id)? onTap;

  const UiTree({
    super.key,
    this.indent = 10.0,
    required this.data,
    required this.itemBuilder,
    this.onTap,
  });

  @override
  State<UiTree<T>> createState() => _UiTreeState<T>();
}

class _UiTreeState<T> extends State<UiTree<T>> {
  List<_Tree<T>> treeList = [];

  String selectedId = "";

  late Color activeBackgroundColor;

  @override
  void initState() {
    super.initState();
    buildTree();
  }

  @override
  @override
  void didUpdateWidget(UiTree<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    //TODO 这里可以把 UiTreeItem 中的 T data 改为 String data，然后重写 ==，使用 listEquals 比较
    buildTree();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: treeList.map((e) => buildItem(e)).toList(),
      ),
    );
  }

  Widget buildItem(_Tree<T> tree) {
    tree.selected = selectedId == tree.item.id;
    return Padding(
      padding: EdgeInsets.only(left: widget.indent * tree.level),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (selectedId != tree.item.id) {
                widget.onTap?.call(tree.item.id);
              }
              selectedId = tree.item.id;
              if (tree.expand) {
                //展开
                if (tree.selected) {
                  //被选中
                  tree.expand = false; //收起
                } else {
                  //没被选中
                  //啥也不干
                }
              } else {
                //关闭
                tree.expand = true;
              }
              setState(() {});
            },
            child: widget.itemBuilder(
              context,
              tree.item.data,
              tree.children.length,
              tree.level,
              tree.expand,
              tree.selected,
            ),
          ),
          Visibility(
            visible: tree.expand,
            child: Column(
              children: tree.children.map((e) => buildItem(e)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void buildTree() {
    final Map<String, _Tree<T>> nodeMap = {};
    for (var item in widget.data) {
      nodeMap[item.id] = _Tree<T>()
        ..item = item
        ..children = [];
    }

    for (var item in widget.data) {
      final node = nodeMap[item.id]!;

      if (item.pid.isEmpty) {
        node.level = 0;
        treeList.add(node);
      } else {
        final parentNode = nodeMap[item.pid];
        if (parentNode != null) {
          node.level = parentNode.level + 1;
          parentNode.children.add(node);
        } else {
          node.level = 0;
          treeList.add(node);
        }
      }
    }
  }
}

class UiTreeItem<T> {
  String id = "";
  String pid = "";
  late T data;
}

class _Tree<T> {
  int level = 0;
  bool expand = false;
  bool selected = false;
  late UiTreeItem<T> item;
  List<_Tree<T>> children = [];
}
