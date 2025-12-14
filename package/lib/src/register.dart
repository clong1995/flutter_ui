import 'package:flutter/material.dart';

class Register {
  Register(this.name, this.packageBuilder);

  final String name;
  final Widget Function({
    Object? arg,
  })
  packageBuilder;
}
