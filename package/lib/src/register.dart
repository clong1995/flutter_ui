import 'package:flutter/widgets.dart';

class Register {
  Register(this.name, this.builder);

  final String name;
  final Widget Function()
  builder;
}

typedef PkgReg = Iterable<Register Function()>;
