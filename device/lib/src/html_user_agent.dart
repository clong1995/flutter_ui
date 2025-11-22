import 'dart:js_interop';

@JS('navigator')
external Navigator get navigator;

@JS()
extension type Navigator._(JSObject _) implements JSObject {
  external String get userAgent;
}

String userAgent = navigator.userAgent;
