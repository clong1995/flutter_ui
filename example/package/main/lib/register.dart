import 'package:button/widget.dart';
import 'package:home/widget.dart';
import 'package:package/package.dart';
import 'package:page/widget.dart';
import 'package:splash/home/widget.dart' as splash;

final PkgReg registers = {
  'splash': splash.homeWidget,
  'home': home.homeWidget,
  'page': pageWidget,
  'button': buttonWidget,
};
