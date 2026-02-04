import 'package:package/package.dart';
import 'package:splash/home/widget.dart';
import 'package:ui_app/ui_app.dart';

Future<void> mainApp() async {
  Package.register();
  await uiApp(
    title: 'Flutter UI',
    home: homeWidget(),
  );
}
