import 'package:flutter/material.dart';

import 'src/region_widget.dart';

Future<List<Region>?> region(
  BuildContext context, {
  String? region, //如：山东省/青岛市/黄岛区
  Future<String?> Function()? location, //如：返回 山东省/青岛市/黄岛区
  bool rootNavigator = false,
}) async {
  return await Navigator.of(
    context,
    rootNavigator: rootNavigator,
  ).push<List<Region>>(
    MaterialPageRoute<List<Region>>(
      builder:
          (BuildContext context) =>
              RegionWidget(region: region, location: location),
    ),
  );
}

class Region {
  String code = "";
  String name = "";
}
