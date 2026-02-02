import 'package:flutter/widgets.dart';
import 'package:ui_app/src/builder.dart';
import 'package:ui_theme/ui_theme.dart';

class App extends StatelessWidget {
  const App({required this.home, this.navigatorKey, super.key, this.title});

  final String? title;
  final Widget home;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: title,
      home: home,
      navigatorKey: navigatorKey,
      pageRouteBuilder: <T>(settings, builder) => PageRouteBuilder<T>(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),

        //transitionDuration: Duration.zero,
        //reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0); // 从右边进入
          const end = Offset.zero;
          const curve = Curves.easeOut; // 减速曲线，感觉更顺滑

          final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
      debugShowCheckedModeBanner: false,
      color: UiTheme.primaryColor,
      builder: builder,
    );
  }
}
