import 'package:flutter/material.dart';

class Register {
  Register(this.name, this.builder);

  final String name;
  final Widget Function({
    Object? arg,
  })
  builder;
}
