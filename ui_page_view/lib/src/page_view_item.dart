import 'package:flutter/material.dart';

class PageViewItem extends StatefulWidget {
  final Widget child;
  final bool keepAlive;
  final bool nestRoute;

  const PageViewItem({
    super.key,
    required this.child,
    this.keepAlive = false,
    this.nestRoute = false,
  });

  @override
  State<PageViewItem> createState() => _PageViewItemState();
}

class _PageViewItemState extends State<PageViewItem>
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
