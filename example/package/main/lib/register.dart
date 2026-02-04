import 'package:home/home/widget.dart' as home;
import 'package:package/package.dart';
import 'package:splash/home/widget.dart' as splash;

final PkgReg registers = [
  ()=> Register('splash', splash.homeWidget),
  ()=> Register('home', home.homeWidget),
];
