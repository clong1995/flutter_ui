import 'package:flutter/material.dart';
import 'package:ui_avatar/src/single.dart';

class UiAvatarStack extends StatelessWidget {
  const UiAvatarStack({
    required this.images,
    super.key,
    this.max = 5,
    this.height = 26,
  });

  final int max;
  final double height;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    var length = images.length;
    if (length <= 0) {
      return const SizedBox.shrink();
    }
    if (length > max) {
      length = max;
    }
    final offset = height / 3;
    final width = length * height - (length - 1) * offset;
    final list = images.sublist(0, length);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: list
            .asMap()
            .entries
            .map((entry) {
              final index = entry.key;
              return Positioned(
                left: (index * height) - index * offset,
                child: UiAvatarSingle(
                  imageUrl: entry.value,
                  size: height,
                  border: Border.all(color: Colors.white, width: 2),
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
