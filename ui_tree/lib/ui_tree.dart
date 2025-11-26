import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UiTree<T extends Comparable<T>> extends StatefulWidget {
  const UiTree({
    required this.data,
    required this.itemBuilder,
    super.key,
    this.indent = 10.0,
    this.selectedId = '',
    this.onTap,
  });

  final double indent;
  final String selectedId;
  final List<UiTreeItem<T>> data;
  final Widget Function(
      BuildContext context,
      UiTreeItem<T> item,
      int length,
      int level,
      bool expand,
      bool selected,
      )
  itemBuilder;

  final void Function(UiTreeItem<T> item)? onTap;

  @override
  State<UiTree<T>> createState() => _UiTreeState<T>();
}

class _UiTreeState<T extends Comparable<T>> extends State<UiTree<T>> {
  List<_Tree<T>> treeList = [];

  String selectedId = '';

  late Color activeBackgroundColor;

  @override
  void initState() {
    super.initState();
    buildTree();
  }

  @override
  void didUpdateWidget(UiTree<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.data, oldWidget.data) ||
        widget.indent != oldWidget.indent ||
        widget.selectedId != oldWidget.selectedId) {
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
        children: treeList.map(buildItem).toList(),
      ),
    );
  }

  Widget buildItem(_Tree<T> tree) {
    tree.selected = selectedId == tree.item.id;
    return Padding(
      key: ValueKey(tree.item.id),
      padding: EdgeInsets.only(left: widget.indent * tree.level),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (selectedId != tree.item.id) {
                widget.onTap?.call(tree.item);
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
              children: tree.children.map(buildItem).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void buildTree() {
    selectedId = widget.selectedId;
    treeList.clear();
    final nodeMap = <String, _Tree<T>>{};
    for (final item in widget.data) {
      nodeMap[item.id] = _Tree<T>()
        ..item = item
        ..children = [];
    }

    for (final item in widget.data) {
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

/*class UiTreeItem<T>{
  String id = "";
  String pid = "";
  T? data;

  @override
  bool operator ==(Object other) =>
      other is UiTreeItem &&
      id == other.id &&
      pid == other.pid &&
      data == other.data;

  @override
  int get hashCode => id.hashCode ^ pid.hashCode ^ data.hashCode;
}*/

@immutable
class UiTreeItem<T extends Comparable<T>> {
  const UiTreeItem({required this.id, required this.data, this.pid = ''});

  final String id;
  final String pid;
  final T data;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UiTreeItem<T>) return false;
    return id == other.id &&
        pid == other.pid &&
        (data.compareTo(other.data) == 0);
  }

  @override
  int get hashCode => Object.hash(id, pid, data);
}

class _Tree<T extends Comparable<T>> {
  int level = 0;
  bool expand = false;
  bool selected = false;
  late UiTreeItem<T> item;
  List<_Tree<T>> children = [];
}
