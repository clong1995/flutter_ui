import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_theme/ui_theme.dart';

class UiTree<T extends Object?> extends StatefulWidget {
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

  final void Function(String id, List<String> expandedId)? onTap;

  @override
  State<UiTree<T>> createState() => _UiTreeState<T>();
}

class _UiTreeState<T extends Object?> extends State<UiTree<T>> {
  List<UiTreeItemBranch<T>> treeList = [];
  List<String> expandedId = [];
  String selectedId = ''; //代替遍历树状结构算法

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
    //代替遍历树状结构算法
    treeBranch.item.selected = treeBranch.item.item.id == selectedId;

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
              //代替遍历树状结构算法
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
              widget.onTap?.call(treeBranch.item.item.id, expandedId);
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
          if (item.selected)
            Icon(
              Icons.chevron_right_rounded,
              color: selectedFontColor,
            ),
        ],
      ),
    );
  }

  void buildTree() {
    expandedId = widget.expandedId ?? <String>[];
    if (widget.selectedId.isNotEmpty) {
      expandedId.add(widget.selectedId);
    }
    expandedId = expandedId.toSet().toList();

    treeList.clear();
    final nodeMap = <String, UiTreeItemBranch<T>>{};
    for (final item in widget.data) {
      nodeMap[item.id] = UiTreeItemBranch<T>()
        ..item = (UiTreeItemOne<T>()
          ..selected = widget.selectedId == item.id
          ..expand = expandedId.contains(item.id)
          ..item = UiTreeItem<T>(
            id: item.id,
            pid: item.pid,
            title: item.title,
            data: item.data,
          ))
        ..children = [];
    }

    for (final item in widget.data) {
      final node = nodeMap[item.id]!;

      if (item.pid.isEmpty || item.id == item.pid) {
        node.item.level = 0;
        treeList.add(node);
      } else {
        final parentNode = nodeMap[item.pid];
        if (parentNode != null) {
          node.item.level = parentNode.item.level + 1;
          parentNode.children.add(node);
          if (!parentNode.item.expand) {
            parentNode.item.expand = node.item.expand; //当子项目展开的时候，父项目也要展开
          }
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
class UiTreeItem<T extends Object?> {
  const UiTreeItem({this.id = '', this.pid = '', this.title = '', this.data});

  final String id;
  final String pid;
  final String title;
  final T? data;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UiTreeItem<T>) return false;
    return id == other.id &&
        pid == other.pid &&
        title == other.title &&
        data == other.data;
  }

  @override
  int get hashCode => Object.hash(id, pid, title, data);
}

class UiTreeItemBranch<T extends Object?> {
  late UiTreeItemOne<T> item;
  List<UiTreeItemBranch<T>> children = [];
}

class UiTreeItemOne<T extends Object?> {
  int level = 0;
  bool expand = false;
  bool selected = false;
  int len = 0;
  late UiTreeItem<T> item;
}
