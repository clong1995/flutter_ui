import 'package:flutter/material.dart';

import 'address_widget.dart';

Future<Address?> address(
  BuildContext context, {
  required Future<List<Address>> Function(String keyword) datasource,
  bool rootNavigator = false,
  Future<List<double>?> Function()? location,
}) async {
  return await Navigator.of(
    context,
    rootNavigator: rootNavigator,
  ).push<Address>(
    MaterialPageRoute<Address>(
      builder:
          (BuildContext context) =>
              AddressWidget(datasource: datasource, location: location),
    ),
  );
}

class Address {
  String province = "";
  String city = "";
  String county = "";
  String address = "";
  List<double> lonLat = [];
  String name = "";
  String typeName = "";
}
