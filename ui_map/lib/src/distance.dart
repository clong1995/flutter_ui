import 'dart:math';

const double _r = 6371000; // 地球半径，单位是米
double distance(List<double> lonLat1, List<double> lonLat2) {
  if (lonLat1.length != 2 || lonLat2.length != 2) {
    return 0;
  }
  // 将经纬度转换为弧度
  final phi1 = _radians(lonLat1[1]);
  final phi2 = _radians(lonLat2[1]);
  final deltaPhi = _radians(lonLat2[1] - lonLat1[1]);
  final deltaLambda = _radians(lonLat2[0] - lonLat1[0]);

  // Haversine 公式
  final a =
      sin(deltaPhi / 2) * sin(deltaPhi / 2) +
      cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // 返回两点之间的距离
  return _r * c; // 返回单位是米
}

double _radians(double degree) => degree * pi / 180;
