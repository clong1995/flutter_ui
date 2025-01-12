import 'package:flutter/material.dart';
import 'src/region_widget.dart';

Region? region(BuildContext context, {
  String? code,
  bool rootNavigator = false,
}) {
  Navigator.of(context, rootNavigator: rootNavigator).push<Region>(
    MaterialPageRoute<Region>(
      builder: (BuildContext context) => RegionWidget(),
      settings: RouteSettings(
        arguments: code,
      ),
    ),
  );
  return null;
}

class Region {
  String name = "";
  String code = "";
}