import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/colors.dart';
import 'package:musify/core/utils/screen_size.dart';
import 'package:musify/feature/app/presentation/provider/tab_provider.dart';

class PageNavigationBar extends StatelessWidget {
  const PageNavigationBar({
    super.key,
    required this.tabIndex,
    required this.pageController,
  });
  final int tabIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        border: const Border(
          top: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
          bottom: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabItems.length, (index) {
          final tab = tabItems[index];
          return GestureDetector(
            onTap: () {
              pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            child: Container(
              width: ScreenSize.width / 4,

              color: AppColors.surfaceDark,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      tab.icon,
                      color: tabIndex == index ? AppColors.primary : null,
                      size: tabIndex == index ? 33 : 30,
                    ),
                    Text(
                      tab.label,
                      style: TextStyle(
                        color: tabIndex == index ? AppColors.primary : null,
                        fontWeight: tabIndex == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
