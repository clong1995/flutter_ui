import 'package:geolocator/geolocator.dart';
import 'package:ui_toast/toast.dart';

Position? _position;
//type:
//cache 最快 缓存（last和current都会更新这个位置）
//last 快 最后一个位置
//current 慢 实时位置
Future<List<double>?> location([String type = "cache"]) async {
  final p = await _permission();
  if (!p) return null;
  if(type == "cache"){
    _position ??= await Geolocator.getLastKnownPosition();
    _position ??= await Geolocator.getCurrentPosition();
  }else if(type == "last"){
    _position = await Geolocator.getLastKnownPosition();
    _position ??= await Geolocator.getCurrentPosition();
  }else {
    _position = await Geolocator.getCurrentPosition();
  }
  return _position == null?null:[_position!.longitude, _position!.latitude];
}

Future<bool> _permission() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    //Location services are disabled
    Toast.show(Toast.info..text = "location service disabled");
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
      Toast.show(Toast.info..text = "location  permissions are denied");
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    //Location permissions are permanently denied, we cannot request permissions.
    Toast.show(Toast.info..text = "location permissions are denied forever");
    return false;
  }


  return true;
}
