import 'package:main/register.dart';
import 'package:package/package.dart';
import 'package:ui_app/ui_app.dart';

Future<void> mainApp() async {
  //
  Register.pkgReg = registers;

  //
  await uiApp(
    title: 'Flutter UI',
    home: Register.get('splash')(),
  );
}
