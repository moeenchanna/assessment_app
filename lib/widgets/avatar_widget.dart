import 'package:flutter/material.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import '../util/utils.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? imagePadding;

  const AvatarWidget({
    Key? key,
    this.imageUrl,
    this.size = 40,
    this.backgroundColor = ColorUtil.orangeColor,
    this.padding,
    this.imagePadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
        ),
        child: ClipOval(
          child: Padding(
            padding: imagePadding ?? EdgeInsets.all(size! * 0.1), // Default inner padding of 10% of size
            child: FastCachedImage(
              url: imageUrl ?? NetworkImageUrls.defaultAvatar,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 300),
              errorBuilder: (context, exception, stacktrace) {
                return Icon(Icons.person, size: size! * 0.5, color: ColorUtil.whiteColor);
              },
              loadingBuilder: (context, progress) {
                return Center(
                  child: CircularProgressIndicator(
                    value: progress.progressPercentage.value,
                    color: ColorUtil.whiteColor,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}