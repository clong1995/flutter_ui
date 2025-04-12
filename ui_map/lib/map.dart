import 'package:flutter/material.dart';
import 'package:ui_webview/ui_webview.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return const UiWebview(url: "packages/ui_map/html/index.html");
  }
}
