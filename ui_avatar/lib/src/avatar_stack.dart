import 'package:flutter/material.dart';

import 'avatar.dart';

class AvatarStack extends StatelessWidget {
  final int max;
  final double height;
  final List<String> images;

  const AvatarStack({
    super.key,
    this.max = 5,
    this.height = 26,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    int length = images.length;
    if (length <= 0) {
      return const SizedBox.shrink();
    }
    if (length > max) {
      length = max;
    }
    double offset = height / 3;
    double width = length * height - (length - 1) * offset;
    List<String> list = images.sublist(0, length);
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: list
            .asMap()
            .entries
            .map((entry) {
              int index = entry.key;
              return Positioned(
                left: (index * height) - index * offset,
                child: Avatar(
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
