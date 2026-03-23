import 'package:flutter/widgets.dart';

class UiWebview extends StatefulWidget {
  const UiWebview({required this.url, this.register, super.key});

  final String url;
  final Map<String, Future<dynamic> Function(dynamic json)>? register;

  @override
  State<UiWebview> createState() => _MyPlatformWidgetState();
}

class _MyPlatformWidgetState extends State<UiWebview> {
  @override
  Widget build(BuildContext context) {
    throw UnsupportedError('未知平台，无法创建 Widget');
  }
}
