import 'package:flutter/material.dart';
import 'package:fn_nav/fn_nav.dart';
import 'package:ui_map/src/address_widget.dart';

Future<Address?> address(
  BuildContext context, {
  required Future<List<Address>> Function(String keyword) datasource,
  bool root = false,
  Future<List<double>?> Function()? location,
}) => FnNav.push<Address>(
  root: root,
  () => AddressWidget(datasource: datasource, location: location),
);

class Address {
  String province = '';
  String city = '';
  String county = '';
  String address = '';
  List<double> lonLat = [];
  String name = '';
  String typeName = '';
}
