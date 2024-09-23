import 'package:flutter/material.dart';

mixin Lifecycle {
  void onInit() {}

  void onDispose() {}

  BuildContext get context;
}