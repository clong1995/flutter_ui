import 'package:flutter/material.dart';

import 'src/region_widget.dart';

Future<List<Region>?> region(
  BuildContext context, {
  String? code,
  bool rootNavigator = false,
}) async {
  return await Navigator.of(context, rootNavigator: rootNavigator)
      .push<List<Region>>(
    MaterialPageRoute<List<Region>>(
      builder: (BuildContext context) => RegionWidget(),
      settings: RouteSettings(
        arguments: code,
      ),
    ),
  );
}

class Region {
  String code = "";
  String name = "";
}