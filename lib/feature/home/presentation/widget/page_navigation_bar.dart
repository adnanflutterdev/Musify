import 'package:flutter/material.dart';
import 'package:musify/core/const/app_spacing.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
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
        gradient: LinearGradient(
          begin: .topCenter,
          end: .bottomCenter,
          stops: context.colors.gradientStopsR,
          colors: context.colors.gradient.reversed.toList(),
        ),

        border: Border(
          top: BorderSide(color: context.colors.border, width: 0.7),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Column(
        children: [
          Row(
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

                  color: context.colors.transparent,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          tab.icon,
                          color: tabIndex == index
                              ? context.colors.primary
                              : null,
                          size: tabIndex == index ? 33 : 30,
                        ),
                        Text(
                          tab.label,
                          style: TextStyle(
                            color: tabIndex == index
                                ? context.colors.primary
                                : null,
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
        ],
      ),
    );
  }
}
