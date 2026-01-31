import 'package:flutter/widgets.dart';
import 'package:ui_app/src/builder.dart';

class UiApp extends StatelessWidget {
  const UiApp({required this.home, super.key, this.title});

  final String? title;
  final Widget home;

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: title,
      home: home,
      pageRouteBuilder: <T>(RouteSettings settings, WidgetBuilder builder) =>
          PageRouteBuilder<T>(
            settings: settings,
            pageBuilder: (context, animation, secondaryAnimation) =>
                builder(context),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
      debugShowCheckedModeBanner: false,
      color: const Color(0xFF5681F6),
      //textStyle: const TextStyle(color: Color(0xFF333333), fontSize: 16),
      /*builder: (BuildContext context, Widget? child) {
        return ColoredBox(
          color: const Color(0xFFFFFFFF),
          child: child,
        );
      },*/
      builder: builder,
    );
  }
}
