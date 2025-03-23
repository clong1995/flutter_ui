import 'package:geolocator/geolocator.dart';

Future<List<double>?> location() async {
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

  return [position.longitude,position.latitude];
}