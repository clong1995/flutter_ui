import 'package:flutter/material.dart';
import 'package:ui_webview/ui_webview.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    return const UiWebview(url: 'packages/ui_map/html/tianditu.html');
  }
}
