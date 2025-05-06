import 'package:flutter/material.dart';

class UiTree<T> extends StatefulWidget {
  final List<UiTreeItem<T>> data;
  final Widget Function(T data) itemBuilder;

  const UiTree({super.key, required this.data, required this.itemBuilder});

  @override
  State<UiTree<T>> createState() => _UiTreeState<T>();
}

class _UiTreeState<T> extends State<UiTree<T>> {
  List<_Tree<T>> treeList = [];

  @override
  void initState() {
    super.initState();
    _buildTree();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _buildTree() {
    final Map<String, _Tree<T>> nodeMap = {};
    for (var item in widget.data) {
      nodeMap[item.id] =
          _Tree<T>()
            ..item = item
            ..children = [];
    }

    for (var item in widget.data) {
      final node = nodeMap[item.id]!;

      if (item.pid.isEmpty) {
        treeList.add(node);
      } else {
        final parentNode = nodeMap[item.pid];
        if (parentNode != null) {
          parentNode.children.add(node);
        } else {
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
  late UiTreeItem<T> item;
  List<_Tree<T>> children = [];
}
