import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_theme/ui_theme.dart';

class UiTree<T extends Comparable<T>> extends StatefulWidget {
  const UiTree({
    required this.data,
    this.itemBuilder,
    super.key,
    this.indent,
    this.selectedId = '',
    this.expandedId,
    this.onTap,
  });

  final double? indent;
  final String selectedId;
  final List<String>? expandedId;
  final List<UiTreeItem<T>> data;
  final Widget Function(
    BuildContext context,
    UiTreeItemOne<T> item,
  )?
  itemBuilder;

  final void Function(String selectedId,List<String> expandedId)? onTap;

  @override
  State<UiTree<T>> createState() => _UiTreeState<T>();
}

class _UiTreeState<T extends Comparable<T>> extends State<UiTree<T>> {
  List<UiTreeItemBranch<T>> treeList = [];

  String selectedId = '';
  List<String> expandedId = [];

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
        widget.selectedId != oldWidget.selectedId) {
      buildTree();
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

  Widget buildItem(UiTreeItemBranch<T> treeBranch) {
    treeBranch.item.selected = selectedId == treeBranch.item.item.id;

    return Padding(
      key: ValueKey(treeBranch.item.item.id),
      padding: EdgeInsets.only(
        left: widget.indent ?? 10.r * treeBranch.item.level,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              if (selectedId != treeBranch.item.item.id) {
                widget.onTap?.call(selectedId,expandedId);
              }
              selectedId = treeBranch.item.item.id;
              if (treeBranch.item.expand) {
                //展开
                if (treeBranch.item.selected) {
                  //被选中
                  treeBranch.item.expand = false; //收起
                  expandedId.removeWhere((e) => e == treeBranch.item.item.id);
                } else {
                  //没被选中
                  //啥也不干
                }
              } else {
                //关闭
                treeBranch.item.expand = true;
                expandedId.add(treeBranch.item.item.id);
              }
              setState(() {});
            },
            child: widget.itemBuilder == null
                ? itemBuilder(context, treeBranch.item)
                : widget.itemBuilder!(context, treeBranch.item),
          ),
          if (treeBranch.children.isNotEmpty)
            Visibility(
              visible: treeBranch.item.expand,
              child: Column(
                children: treeBranch.children.map(buildItem).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget itemBuilder(
    BuildContext context,
    UiTreeItemOne<T> item,
  ) {
    final selectedFontColor = item.selected ? UiTheme.white : UiTheme.black;
    final selectedFontWeight = item.selected ? FontWeight.bold : null;
    final selectedBackgroundColor = item.selected
        ? UiTheme.primaryColor
        : UiTheme.white;
    return Container(
      key: ValueKey(item.item.id),
      height: 34.r,
      decoration: BoxDecoration(
        color: selectedBackgroundColor,
        borderRadius: BorderRadius.circular(5.r),
      ),
      margin: EdgeInsets.only(bottom: 4.r),
      padding: EdgeInsets.symmetric(horizontal: 5.r),
      child: Row(
        children: [
          if (item.len == 0)
            SizedBox(
              width: 5.r,
            )
          else
            Icon(
              item.expand ? Icons.arrow_drop_down : Icons.arrow_right,
              color: selectedFontColor,
            ),
          Expanded(
            child: Text(
              item.item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: selectedFontColor,
                fontWeight: selectedFontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void buildTree() {
    selectedId = widget.selectedId;
    expandedId = widget.expandedId ?? <String>[];
    if (selectedId.isNotEmpty) {
      expandedId.add(selectedId);
    }
    expandedId = expandedId.toSet().toList();

    treeList.clear();
    final nodeMap = <String, UiTreeItemBranch<T>>{};
    for (final item in widget.data) {
      nodeMap[item.id] = UiTreeItemBranch<T>()
        ..item = UiTreeItemOne<T>()
        ..item = UiTreeItemOne<T>()
        ..children = [];
    }

    for (final item in widget.data) {
      final node = nodeMap[item.id]!;

      if (item.pid.isEmpty) {
        node.item.level = 0;
        treeList.add(node);
      } else {
        final parentNode = nodeMap[item.pid];
        if (parentNode != null) {
          node.item.level = parentNode.item.level + 1;
          parentNode.children.add(node);
          parentNode.item.len = parentNode.children.length;
        } else {
          node.item.level = 0;
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
  const UiTreeItem({
    required this.id,
    required this.data,
    required this.title,
    this.pid = '',
  });

  final String id;
  final String pid;
  final String title;
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

class UiTreeItemBranch<T extends Comparable<T>> {
  late UiTreeItemOne<T> item;
  List<UiTreeItemBranch<T>> children = [];
}

class UiTreeItemOne<T extends Comparable<T>> {
  int level = 0;
  bool expand = false;
  bool selected = false;
  int len = 0;
  late UiTreeItem<T> item;
}
