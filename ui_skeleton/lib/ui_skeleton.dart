import 'package:flutter/material.dart' show CircularProgressIndicator, Icons;
import 'package:flutter/widgets.dart';
import 'package:ui_button/ui_button.dart';
import 'package:ui_theme/ui_theme.dart';

class UiSkeleton extends StatefulWidget {
  const UiSkeleton({
    required this.child,
    super.key,
    this.state = UiSkeletonState.data,
    this.none,
  });

  final UiSkeletonState state;
  final Widget child;
  final Widget? none;

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
      child =
          widget.none ??
          Image.asset(
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

class UiSkeletonRefreshNone extends StatelessWidget {
  const UiSkeletonRefreshNone({required this.onRefreshTap, super.key});

  final void Function() onRefreshTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'images/not_data.png',
          package: 'ui_skeleton',
          fit: BoxFit.fitWidth,
        ),
        UiTextButton(
          icon: Icons.refresh,
          text: '刷 新',
          onTap: onRefreshTap,
        ),
      ],
    );
  }
}
