import 'package:flutter/material.dart';
import 'package:nav/nav.dart';

import 'region_widget.dart';

Future<List<Region>?> region(
  BuildContext context, {
  String? region, //如：山东省/青岛市/黄岛区
  Future<String?> Function()? location, //如：返回 山东省/青岛市/黄岛区
  bool root = false,
}) => Nav.push<List<Region>>(
  root: root,
  context,
  () => RegionWidget(region: region, location: location),
);

class Region {
  String code = "";
  String name = "";
}
