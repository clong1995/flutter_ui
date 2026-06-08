import 'package:flutter/material.dart';
import 'package:ui_theme/ui_theme.dart';

class UiSkeleton extends StatefulWidget {
  const UiSkeleton({
    required this.child,
    super.key,
    this.state = UiSkeletonState.data,
  });

  final UiSkeletonState state;
  final Widget child;

  @override
  State<UiSkeleton> createState() => _UiSkeletonState();
}

class _UiSkeletonState extends State<UiSkeleton> {
  @override
  Widget build(BuildContext context) {
    final visible = widget.state == UiSkeletonState.data;
    return Stack(
      children: [
        Offstage(
          offstage: !visible,
          child: widget.child,
        ),
        if (!visible) replacement(),
      ],
    );
  }

  Widget replacement() {
    Widget child = const SizedBox.shrink();
    if (widget.state == UiSkeletonState.hold) {
      child = CircularProgressIndicator(
        color: UiTheme.primaryColor,
      );
    } else if (widget.state == UiSkeletonState.none) {
      child = Image.asset(
        'images/not_data.png',
        package: 'ui_skeleton',
        fit: BoxFit.fitWidth,
      );
    }
    return Center(
      child: child,
    );
  }
}

enum UiSkeletonState { data, hold, none }
