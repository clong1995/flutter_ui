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
    return Visibility(
      visible: widget.state == UiSkeletonState.data,
      replacement: replacement(),
      child: widget.child,
    );
  }

  Widget replacement() {
    if (widget.state == UiSkeletonState.hold) {
      return Center(
        child: CircularProgressIndicator(
          color: UiTheme.primaryColor,
        ),
      );
    } else if (widget.state == UiSkeletonState.none) {
      return Image.asset(
        'images/not_found.png',
        package: 'ui_skeleton',
        fit: BoxFit.fitWidth,
      );
    }
    return const SizedBox.shrink();
  }
}

enum UiSkeletonState { data, hold, none }
