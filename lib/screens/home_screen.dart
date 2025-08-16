import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musify/functions/auth_functions.dart';
import 'package:musify/services/providers/song_search_provider.dart';
import 'package:musify/services/providers/tabs_provider.dart';
import 'package:musify/utils/colors.dart';
import 'package:musify/utils/images.dart';
import 'package:musify/utils/screen_size.dart';
import 'package:musify/utils/spacers.dart';
import 'package:musify/utils/tabs.dart';
import 'package:musify/utils/text.dart';
import 'package:musify/widgets/song_track.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreen();
}

class _HomeScreen extends ConsumerState<HomeScreen> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void alertDialog({
    required String title,
    required String subTitle,
    required VoidCallback callBack,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.cardBackground,
        title: errorText(title),
        content: whiteTextSmall(subTitle),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: whiteTextSmall('Cancel'),
          ),
          TextButton(onPressed: callBack, child: errorText(title)),
        ],
      ),
    );
  }

  void exitScreen() {
    Navigator.pop(context);
    SystemNavigator.pop();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentTab = ref.watch(tabProvider);
    final tabNotifier = ref.watch(tabProvider.notifier);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        } else {
          alertDialog(
            title: 'Exit app',
            subTitle: 'Are you sure to want to exit',
            callBack: () {
              exitScreen();
            },
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(onTap: () {}, child: Image.asset(logo)),
            ),
            title: Row(
              children: [
                Image.asset(musifyTextLogo, height: 28),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    alertDialog(
                      title: 'Logout',
                      subTitle: 'Are you sure to want to logout',
                      callBack: () => logout(context),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.inputBackground,
                  ),
                  icon: Icon(
                    Icons.logout_rounded,
                    color: AppColors.white,
                    size: 20,
                  ),
                  label: Text(
                    'Logout',
                    style: TextStyle(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: AppColors.cardBackground,
          ),
          backgroundColor: AppColors.primaryBackground,
          body: Column(
            children: [
              // Tabs
              Expanded(
                child: PageView.builder(
                  itemCount: tabs.length,
                  controller: _pageController,
                  onPageChanged: (value) {
                    tabNotifier.changeTab(value);
                    if (value == 1) {
                      ref.watch(searchedTextProvider.notifier).clearState();
                    }
                  },
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => tabs[index],
                ),
              ),
              SongTrack(),
              Container(
                color: AppColors.cardBackground,
                width: ScreenSize.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                      tabItems.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Container(
                          width: ScreenSize.width / 4,

                          color: AppColors.cardBackground,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  tabItems[index].first,
                                  color: currentTab == index
                                      ? AppColors.primaryPink
                                      : AppColors.white,
                                  size: currentTab == index ? 33 : 30,
                                ),
                                w5,
                                Text(
                                  tabItems[index].last,
                                  style: TextStyle(
                                    color: currentTab == index
                                        ? AppColors.primaryPink
                                        : AppColors.white,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
