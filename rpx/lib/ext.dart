import 'rpx.dart';

extension RpxExt on num {
  double get r => Rpx.rpx(toDouble());
}
