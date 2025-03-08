import 'dart:io';

import 'package:websocket/print.dart';

WebSocket? _socket;

WebSocket? get socket => _socket;

final Duration _reconnectDelay = const Duration(seconds: 1);

Future<void> connect({
  required String url,
  required Function(String data) received,
  Map<String, String>? headers,
}) async {
  try {
    _socket = await WebSocket.connect(url, headers: headers);
    _socket?.listen(
      (data) => received(data),
      onError: (e) async {
        println("socket error: $e");
        await close();
        Future.delayed(
          _reconnectDelay,
          () => connect(url: url, received: received, headers: headers),
        );
      },
      onDone: () => println("socket done"),
    );
  } catch (e) {
    println("socket connect: $e");
    await close();
    Future.delayed(
      _reconnectDelay,
      () => connect(url: url, received: received, headers: headers),
    );
  }
}

Future<void> close() async {
  try {
    await _socket?.close();
  } catch (e) {
    println("socket close: $e");
  }
  _socket = null;
}
