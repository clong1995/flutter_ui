import 'package:websocket/print.dart';

import 'connect.dart' show socket;

bool send(String text) {
  if (socket == null) {
    println("socket is null");
    return false;
  }
  try {
    socket!.add(text);
  } catch (e) {
    println("send error: $e");
    return false;
  }
  return true;
}
