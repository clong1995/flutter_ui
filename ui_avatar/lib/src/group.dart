import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

class UiAvatarGroup extends StatelessWidget {
  const UiAvatarGroup({
    required this.images,
    super.key,
    this.size,
    this.thumbnail = false,
  });

  final List<String> images;
  final double? size;
  final bool thumbnail;

  @override
  Widget build(BuildContext context) {
    final wrapSize = size ?? 55.r;
    final decoration = BoxDecoration(
      color: const Color(0xFFEEEEEE),
      borderRadius: .circular(5.r),
    );

    if (images.isEmpty) {
      return Container(
        width: wrapSize,
        height: wrapSize,
        padding: .all(2.r),
        clipBehavior: .antiAlias,
        decoration: decoration,
      );
    }

    double avatarSize = 0;

    final avatar = images.length >= 9 ? images.sublist(0, 9) : images;

    if (avatar.length == 1) {
      avatarSize = wrapSize - 4.r;
    } else if (avatar.length >= 2 && avatar.length <= 4) {
      avatarSize = (wrapSize - 4.r) / 2;
    } else if (avatar.length >= 4 && avatar.length <= 9) {
      avatarSize = (wrapSize - 4.r) / 3;
    }
    return Container(
      width: wrapSize,
      height: wrapSize,
      padding: .all(2.r),
      clipBehavior: .antiAlias,
      decoration: decoration,
      child: Wrap(
        alignment: .center,
        runAlignment: .center,
        children: avatar
            .map(
              (e) => Container(
                width: avatarSize,
                height: avatarSize,
                padding: .all(1.r),
                child: UiCacheImage(
                  e,
                  fit: .cover,
                  thumbnail: thumbnail,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
