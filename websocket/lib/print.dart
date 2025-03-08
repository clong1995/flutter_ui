import 'package:flutter/foundation.dart';

void println(String str) {
  if (kDebugMode) {
    print("$str\n");
  }
}