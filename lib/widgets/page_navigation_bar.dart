import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/services/providers/tabs_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/screen_size.dart';
import 'package:musify/utils/spacers.dart';

class PageNavigationBar extends ConsumerWidget {
  const PageNavigationBar({super.key, required this.pageController});
  final PageController pageController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int currentTab = ref.watch(tabProvider);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        border: Border(
          top: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
          bottom: BorderSide(color: AppColors.surfaceMuted, width: 0.7),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          tabItems.length,
          (index) => GestureDetector(
            onTap: () {
              pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
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
                      tabItems[index].first,
                      color: currentTab == index
                          ? AppColors.primary
                          : AppColors.surfaceWhite,
                      size: currentTab == index ? 33 : 30,
                    ),
                    w5,
                    Text(
                      tabItems[index].last,
                      style: TextStyle(
                        color: currentTab == index
                            ? AppColors.primary
                            : AppColors.surfaceWhite,
                        fontWeight: currentTab == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
