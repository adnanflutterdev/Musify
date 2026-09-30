import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/core/utils/colors.dart';
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
          color: AppColors.surface,

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
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.surfaceVariant,
        ),
        child: const Padding(
          padding: EdgeInsets.all(2.5),
          child: Icon(Icons.more_vert, color: AppColors.surfaceWhite, size: 25),
        ),
      ),
    );
  }
}
