import 'dart:async';
import 'dart:io';

import 'package:websocket/print.dart';

WebSocket? _socket;

WebSocket? get socket => _socket;

const Duration _reconnectDelay = Duration(seconds: 1);

bool _break = false;

const timeout = Duration(seconds: 5);

Future<void> connect({
  required String url,
  required Function(String data) received,
  Map<String, String>? headers,
}) async {
  try {
    _socket = await WebSocket.connect(url, headers: headers).timeout(
      timeout,
      onTimeout: () {
        throw TimeoutException('socket connection timed out');
      },
    );
    println("socket state: ${_socket?.readyState}");
    _socket?.listen(
      (data) => received(data),
      onError: (e) async {
        println("socket error: $e");
        await _close();
        if (_break) return;
        Future.delayed(
          _reconnectDelay,
          () => connect(url: url, received: received, headers: headers),
        );
      },
      onDone: () async {
        println("socket done");
        await _close();
        if (_break) return;
        Future.delayed(
          _reconnectDelay,
          () => connect(url: url, received: received, headers: headers),
        );
      },
    );
  } catch (e) {
    println("socket connect: $e");
    await _close();
    if (_break) return;
    Future.delayed(
      _reconnectDelay,
      () => connect(url: url, received: received, headers: headers),
    );
  }
}

Future<void> close() async {
  _break = true;
  await _close();
}

Future<void> _close() async {
  try {
    await _socket?.close();
  } catch (e) {
    println("socket close: $e");
  }
  _socket = null;
}
