import 'dart:math';

const double _r = 6371000; // 地球半径，单位是米
double distance(List<double> lonLat1, List<double> lonLat2) {
  // 将经纬度转换为弧度
  double phi1 = _radians(lonLat1[1]);
  double phi2 = _radians(lonLat2[1]);
  double deltaPhi = _radians(lonLat2[1] - lonLat1[1]);
  double deltaLambda = _radians(lonLat2[0] - lonLat1[0]);

  // Haversine 公式
  double a =
      sin(deltaPhi / 2) * sin(deltaPhi / 2) +
      cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  // 返回两点之间的距离
  return _r * c; // 返回单位是米
}

double _radians(double degree) => degree * pi / 180;
