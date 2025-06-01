import 'package:flutter/material.dart';
import 'package:ui_webview/ui_webview.dart';

class MapViewWidget extends StatefulWidget {
  const MapViewWidget({super.key});

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  @override
  Widget build(BuildContext context) {
    return const UiWebview(url: "packages/ui_map/html/tianditu.html");
  }
}
