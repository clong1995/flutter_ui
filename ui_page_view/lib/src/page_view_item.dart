
// 还可以充当 Keep alive 功能的容器
import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';

class PageViewItem extends StatefulWidget {
  const PageViewItem({
    required this.child,
    super.key,
    this.keepAlive = false,
    this.nestRoute = false,
  });

  final Widget child;
  final bool keepAlive;
  final bool nestRoute;

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
            onGenerateRoute: (settings) => FnNavRouteBuilder(
              settings,
              (context) => widget.child,
            ),
          )
        : widget.child;
  }
}
