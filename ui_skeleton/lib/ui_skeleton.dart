import 'package:flutter/material.dart';

class UiSkeleton extends StatefulWidget {
  const UiSkeleton({
    required this.child,
    super.key,
    this.state = UiSkeletonState.data,
    this.hold,
    this.none,
  });

  final UiSkeletonState state;
  final Widget child;
  final Widget? hold;
  final Widget? none;

  @override
  State<UiSkeleton> createState() => _UiSkeletonState();
}

class _UiSkeletonState extends State<UiSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.state == UiSkeletonState.data,
      replacement: Visibility(
        visible: widget.state == UiSkeletonState.hold,
        replacement: widget.none ?? const Center(child: Text('No data')),
        child: widget.hold ?? const Center(child: CircularProgressIndicator()),
      ),
      child: widget.child,
    );
  }
}

enum UiSkeletonState { data, hold, none }
