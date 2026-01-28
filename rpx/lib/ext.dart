import 'package:rpx/src/rpx.dart';

extension RpxExt on num {
  double get r => rpx(toDouble());
}

void Function() setViewWidth = setWidth;
