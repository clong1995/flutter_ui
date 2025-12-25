import 'package:flutter/material.dart';
import 'package:ui_cache_image/ui_cache_image.dart';

class UiAvatarSingle extends StatelessWidget {
  const UiAvatarSingle({
    super.key,
    this.imageUrl,
    this.size,
    this.package,
    this.border,
  });

  final String? imageUrl;
  final double? size;
  final String? package;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    final size = this.size ?? 50;

    final padding = border?.bottom.width ?? 0;
    return SizedBox(
      height: size,
      width: size,
      child: AspectRatio(
        aspectRatio: 1,
        child: DecoratedBox(
          decoration: BoxDecoration(
            // shape: BoxShape.circle,
            border: border,
            borderRadius: BorderRadius.circular(size / 10),
          ),
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: (imageUrl == null || imageUrl == '')
                ? Icon(Icons.person, color: Colors.grey, size: size / 1.3)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(size / 10),
                    child: imageUrl!.startsWith('http')
                        ? UiCacheImage(imageUrl!, fit: BoxFit.cover)
                        : Image.asset(
                            imageUrl!,
                            fit: BoxFit.cover,
                            package: package,
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
