import 'package:flutter/material.dart';

mixin Lifecycle {
  void onInit() {}

  void onDidChanged() {}

  void onDispose() {}

  BuildContext get context;

  void update([List<String>? ids]) {}
}
