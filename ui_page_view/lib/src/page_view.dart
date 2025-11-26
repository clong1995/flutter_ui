import 'package:flutter/material.dart';

class PageView extends StatefulWidget {
  const PageView({
    required this.child,
    required this.length,
    super.key,
    this.onChanged,
  });

  final int length;
  final void Function(int index)? onChanged;
  final Widget Function(TabController controller) child;

  @override
  State<PageView> createState() => _PageViewState();
}

class _PageViewState extends State<PageView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
    if (widget.onChanged != null) {
      _tabController.addListener(() => widget.onChanged!(_tabController.index));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child(_tabController);
}
