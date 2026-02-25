
// 还可以充当 Keep alive 功能的容器
import 'package:flutter/widgets.dart';
import 'package:fn_nav/fn_nav.dart';

class UiPageViewItem extends StatefulWidget {
  const UiPageViewItem({
    required this.child,
    super.key,
    this.keepAlive = false,
    this.nestRoute = false,
  });

  final Widget child;
  final bool keepAlive;
  final bool nestRoute;

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
            onGenerateRoute: (settings) => FnNavRouteBuilder(
              settings,
              (context) => widget.child,
            ),
          )
        : widget.child;
  }
}
