import 'package:flutter/material.dart' show Icons;
import 'package:flutter/widgets.dart';
import 'package:rpx/ext.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

class UiAvatarSingle extends StatelessWidget {
  const UiAvatarSingle({
    super.key,
    this.imageUrl,
    this.size,
    this.package,
    this.border,
    this.radius,
    this.thumbnail = false,
  });

  final String? imageUrl;
  final double? size;
  final String? package;
  final BoxBorder? border;
  final double? radius;
  final bool thumbnail;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 50.r;

    final padding = border?.bottom.width ?? 0;
    final circularRadius = radius ?? size / 10;
    return SizedBox(
      height: size,
      width: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            border: border,
            borderRadius: .circular(circularRadius),
          ),
          child: Padding(
            padding: .all(padding),
            child: (imageUrl == null || imageUrl == '')
                ? Icon(
                    Icons.account_circle_outlined,
                    color: const Color(0xFF9E9E9E),
                    size: size / 1.3,
                  )
                : ClipRRect(
                    borderRadius: .circular(circularRadius),
                    child: imageUrl!.startsWith('http')
                        ? UiCacheImage(
                            imageUrl!,
                            fit: .cover,
                            thumbnail: thumbnail,
                          )
                        : Image.asset(
                            imageUrl!,
                            fit: .cover,
                            package: package,
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
