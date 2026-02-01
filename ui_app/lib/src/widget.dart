import 'package:flutter/widgets.dart';
import 'package:ui_app/src/builder.dart';
import 'package:ui_theme/ui_theme.dart';

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
      color: UiTheme.primaryColor,
      builder: builder,
    );
  }
}
