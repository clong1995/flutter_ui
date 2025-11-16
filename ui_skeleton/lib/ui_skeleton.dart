import 'package:flutter/material.dart';

class UiSkeleton extends StatefulWidget {
  final UiSkeletonState state;
  final Widget child;
  final Widget? hold;
  final Widget? none;

  const UiSkeleton({
    super.key,
    this.state = UiSkeletonState.data,
    required this.child,
    this.hold,
    this.none,
  });

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
        replacement: widget.none ?? Center(child: Text('No data')),
        child: widget.hold ?? Center(child: const CircularProgressIndicator()),
      ),
      child: widget.child,
    );
  }
}

enum UiSkeletonState { data, hold, none }
