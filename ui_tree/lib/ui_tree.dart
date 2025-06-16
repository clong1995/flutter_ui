import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiTree extends StatefulWidget {
  final double indent;
  final List<UiTreeItem> data;
  final Widget Function(
    BuildContext context,
    UiTreeItem item,
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
  State<UiTree> createState() => _UiTreeState();
}

class _UiTreeState extends State<UiTree> {
  List<_Tree> treeList = [];

  String selectedId = "";

  late Color activeBackgroundColor;

  @override
  void initState() {
    super.initState();
    buildTree();
  }

  @override
  void didUpdateWidget(UiTree oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.data, oldWidget.data)) {
      buildTree();
      setState(() {});
    }
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

  Widget buildItem(_Tree tree) {
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
              tree.item,
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
    treeList.clear();
    final Map<String, _Tree> nodeMap = {};
    for (var item in widget.data) {
      nodeMap[item.id] = _Tree()
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

class UiTreeItem {
  String id = "";
  String pid = "";
  String title = "";

  @override
  bool operator ==(Object other) =>
      other is UiTreeItem &&
      id == other.id &&
      pid == other.pid &&
      title == other.title;

  @override
  int get hashCode => id.hashCode ^ pid.hashCode ^ title.hashCode;
}

class _Tree {
  int level = 0;
  bool expand = false;
  bool selected = false;
  late UiTreeItem item;
  List<_Tree> children = [];
}
