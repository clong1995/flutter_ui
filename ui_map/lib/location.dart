import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

final SharedPreferencesAsync _asyncPrefs = SharedPreferencesAsync();
const String _key = "__location";

Future<List<double>?> location([bool current = false]) async {
  if(!current){
    String? value = await _asyncPrefs.getString(_key);
    if (value != null && value.isNotEmpty) {
      final arr = value.split(",");
      if (arr.length == 2) {
        double? lon = double.tryParse(arr[0]);
        double? lat = double.tryParse(arr[1]);
        if (lon != null && lat != null) {
          if (kDebugMode) {
            print("cache position:$value");
          }
          return [lon, lat];
        }
      }
    }
  }

  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //Location services are disabled
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      //Location permissions are denied
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    //Location permissions are permanently denied, we cannot request permissions.
    return null;
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  final position = await Geolocator.getCurrentPosition();
  final lonlat = [position.longitude, position.latitude];
  await _asyncPrefs.setString(_key, lonlat.join(","));
  if (kDebugMode) {
    print("current position:$lonlat");
  }
  return lonlat;
}
