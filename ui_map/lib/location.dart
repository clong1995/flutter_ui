import 'package:geolocator/geolocator.dart';

Future<List<double>?> location([bool current = false]) async {
  final p = await _permission();
  if (!p) return null;

  Position? position;
  if (current){ //实时精确位置：慢
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
  }else{ //最后一个位置：快
    position = await Geolocator.getLastKnownPosition();
    if(position == null){
      return null;
    }
  }

  return [position.longitude, position.latitude];
}

Future<bool> _permission() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //Location services are disabled
    return false;
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
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    //Location permissions are permanently denied, we cannot request permissions.
    return false;
  }


  return true;
}
