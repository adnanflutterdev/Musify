import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/screen_size.dart';

class MoreButton extends ConsumerWidget {
  const MoreButton({super.key, required this.menuItems});
  final List<PopupMenuItem> menuItems;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTapDown: (details) {
        final dx = details.globalPosition.dx;
        final dy = details.globalPosition.dy;

        showMenu(
          context: context,
          color: context.colors.surface,

          menuPadding: const EdgeInsets.all(5),
          position: RelativeRect.fromLTRB(
            dx,
            dy,
            ScreenSize.width - dx,
            ScreenSize.height - dy,
          ),
          items: menuItems,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colors.surfaceVariant,
        ),
        child: const Padding(
          padding: EdgeInsets.all(2.5),
          child: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
