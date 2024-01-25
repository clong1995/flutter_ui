import 'rpx.dart';

extension RpxExt on num {
  double get r {
    return Rpx.rpx(toDouble());
  }
}