import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart' as flutter_localizations;
import 'package:fn_nav/fn_nav.dart';
import 'package:material_ui/material_ui.dart' as material_ui show GlobalMaterialLocalizations;
import 'package:ui_app/src/builder.dart';
import 'package:ui_theme/ui_theme.dart';

class App extends StatelessWidget {
  const App({
    required this.home,
    this.navigatorKey,
    super.key,
    this.title,
    this.builder,
  });

  final String? title;
  final Widget home;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Widget Function(BuildContext, Widget?)? builder;

  @override
  Widget build(BuildContext context) {
    return WidgetsApp(
      title: title,
      home: home,
      localizationsDelegates: const [
        material_ui.GlobalMaterialLocalizations.delegate,
        flutter_localizations.GlobalWidgetsLocalizations.delegate,
        flutter_localizations.GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh'), // 中文
        Locale('en'), // 英语
      ],
      navigatorKey: navigatorKey,
      pageRouteBuilder: FnNavRouteBuilder.new,
      debugShowCheckedModeBanner: false,
      color: UiTheme.primaryColor,
      builder: (context, child){
       return appBuilder(context,child,builder);
      },
      locale: const Locale('zh', 'CN'),
    );
  }
}
