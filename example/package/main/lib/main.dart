import 'package:flutter/widgets.dart';
import 'package:main/register.dart';
import 'package:package/package.dart';
import 'package:ui_app/ui_app.dart';

Future<void> mainApp() async {
  //
  Register.pkgReg = registers;

  //
  await uiApp(
    title: 'Flutter UI',
    //home: Register.get('splash')(),
    home: const HomePage()
  );
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    //final width = PlatformDispatcher.instance.views.first.physicalSize.width;
    return Center(
      // child: Text('$width'),
      child: Text('hello word'),
    );
  }
}

