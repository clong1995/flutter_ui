import 'package:flutter/material.dart';

class Register {
  final String name;
  final Widget Function({
    Object? arg,
  }) packageBuilder;

  Register(this.name, this.packageBuilder);
}
