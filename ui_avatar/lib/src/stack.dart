import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_avatar/src/single.dart';

class UiAvatarStack extends StatelessWidget {
  const UiAvatarStack({
    required this.images,
    super.key,
    this.max = 5,
    this.height,
  });

  final int max;
  final double? height;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final h = height ?? 26.r;
    var length = images.length;
    if (length <= 0) {
      return const SizedBox.shrink();
    }
    if (length > max) {
      length = max;
    }
    final offset = h / 3;
    final width = length * h - (length - 1) * offset;
    final list = images.sublist(0, length);
    return SizedBox(
      width: width,
      height: h,
      child: Stack(
        children: list
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              return Positioned(
                left: (index * h) - index * offset,
                child: UiAvatarSingle(
                  imageUrl: entry.value,
                  size: h,
                  border: Border.all(
                    color: const Color(0xFFFFFFFF),
                    width: 2.r,
                  ),
                ),
              );
            })
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}
