import 'package:flutter/material.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:ui_map/src/region_widget.dart';

Future<List<Region>?> region(
  BuildContext context, {
  String? region, //如：山东省/青岛市/黄岛区
  Future<String?> Function()? location, //如：返回 山东省/青岛市/黄岛区
  bool root = false,
}) => FnNav.push<List<Region>>(
  root: root,
  () => RegionWidget(region: region, location: location),
);

class Region {
  String code = '';
  String name = '';
}
