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

        transitionDuration: const Duration(milliseconds: 1300),
        reverseTransitionDuration: const Duration(milliseconds: 1300),

        transitionsBuilder: (context, animation, secondaryAnimation, child) =>
            FadeTransition(
              opacity: animation,
              child: child,
            ),
      ),
      debugShowCheckedModeBanner: false,
      color: UiTheme.primaryColor,
      builder: builder,
    );
  }
}
