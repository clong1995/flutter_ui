import 'package:flutter/material.dart';

class UiPageViewItem extends StatefulWidget {
  final Widget child;
  final bool keepAlive;
  final bool nestRoute;

  const UiPageViewItem({
    super.key,
    required this.child,
    this.keepAlive = false,
    this.nestRoute = false,
  });

  @override
  State<UiPageViewItem> createState() => _UiPageViewItemState();
}

class _UiPageViewItemState extends State<UiPageViewItem>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.nestRoute
        ? Navigator(
            onGenerateRoute: (settings) => MaterialPageRoute(
              builder: (context) => widget.child,
            ),
          )
        : widget.child;
  }
}
