import 'package:flutter/material.dart';

class UiPageView extends StatefulWidget {
  final int length;
  final void Function(int index) listener;
  final Widget Function(TabController controller) child;

  const UiPageView({
    super.key,
    required this.listener,
    required this.child,
    required this.length,
  });

  @override
  State<UiPageView> createState() => _UiPageViewState();
}

class _UiPageViewState extends State<UiPageView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.length, vsync: this);
    _tabController.addListener(() => widget.listener(_tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child(_tabController);
}
