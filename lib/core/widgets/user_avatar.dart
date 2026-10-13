import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.avatar, this.showBorder = true});

  final AvatarData avatar;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: avatar.url,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: 150,
          height: 150,
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
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: .circle,
            color: context.colors.surface,
            border: Border.all(width: 2, color: context.colors.primary),
          ),
        );
      },
    );
  }
}
