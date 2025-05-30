import 'package:flutter/material.dart';

class UiPageView extends StatefulWidget {
  final int length;
  final void Function(int index)? onChanged;
  final Widget Function(TabController controller) child;

  const UiPageView({
    super.key,
    this.onChanged,
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
    if(widget.onChanged != null){
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
