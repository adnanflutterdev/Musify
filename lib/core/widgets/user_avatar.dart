import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    required this.avatar,
    this.showBorder = true,
    this.size = 150,
  });

  final AvatarData avatar;
  final bool showBorder;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: avatar.url,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: .circle,
            image: DecorationImage(image: imageProvider, fit: .cover),
            border: showBorder
                ? Border.all(width: 2, color: context.colors.primary)
                : null,
          ),
        );
      },
      placeholder: (context, url) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: .circle,
            color: context.colors.surface,
          ),
        );
      },

      errorWidget: (context, url, error) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: .circle,
            color: context.colors.surface,
          ),
          child: Center(child: Icon(Icons.person, size: (4 / 5) * size)),
        );
      },
    );
  }
}
