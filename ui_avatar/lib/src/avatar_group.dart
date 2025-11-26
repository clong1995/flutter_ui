import 'package:flutter/material.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

class AvatarGroup extends StatelessWidget {
  const AvatarGroup({required this.images, super.key, this.wrapSize = 55});

  final List<String> images;
  final double wrapSize;

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(4),
    );

    if (images.isEmpty) {
      return Container(
        width: wrapSize,
        height: wrapSize,
        padding: const EdgeInsets.all(2),
        clipBehavior: Clip.antiAlias,
        decoration: decoration,
      );
    }

    double avatarSize = 0;

    final avatar = images.length >= 9 ? images.sublist(0, 9) : images;

    if (avatar.length == 1) {
      avatarSize = wrapSize - 4;
    } else if (avatar.length >= 2 && avatar.length <= 4) {
      avatarSize = (wrapSize - 4) / 2;
    } else if (avatar.length >= 4 && avatar.length <= 9) {
      avatarSize = (wrapSize - 4) / 3;
    }
    return Container(
      width: wrapSize,
      height: wrapSize,
      padding: const EdgeInsets.all(2),
      clipBehavior: Clip.antiAlias,
      decoration: decoration,
      child: Wrap(
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.center,
        children: avatar
            .map(
              (e) => Container(
                width: avatarSize,
                height: avatarSize,
                padding: const EdgeInsets.all(1),
                child: UiCacheImage(
                  e,
                  fit: BoxFit.cover,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
