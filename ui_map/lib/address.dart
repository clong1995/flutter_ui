import 'package:flutter/material.dart';

import 'src/address_widget.dart';

Future<Address?> address(
  BuildContext context, {
  required Future<List<Address>> Function(String keyword) datasource,
  bool rootNavigator = false,
}) async {
  return await Navigator.of(
    context,
    rootNavigator: rootNavigator,
  ).push<Address>(
    MaterialPageRoute<Address>(
      builder: (BuildContext context) => AddressWidget(datasource: datasource),
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
